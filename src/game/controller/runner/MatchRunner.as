package game.controller.runner 
{
	import flash.events.Event;
	import game.controller.callback.GameCallback;
	import game.controller.callback.MatchCallback;
	import game.model.player.Player;
	import game.model.match.Level;
	import game.model.match.Match;
	import game.model.tournament.TournamentSettings;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class MatchRunner
	{
		
		public function MatchRunner(callback:MatchCallback, match:Match, settings:TournamentSettings) 
		{
			this.callback = callback;
			this.match = match;
			this.settings = settings;
		}
		
		public function Start(event:Event=null):void
		{
			callback.OnMatchStart(match);
			callback.OnRoundStart(match);
		}
		
		public function Update(event:Event = null):void
		{
			if (match.IsComplete)
			{
				callback.OnRoundEnd(match);
				if (match.Player1Wins >= settings.RoundWinsToWinMatch)
				{
					match.DeclareWinner(player1);
					callback.OnMatchEnd(match);
				}
				else if (match.Player2Wins >= settings.RoundWinsToWinMatch)
				{
					match.DeclareWinner(player2);
					callback.OnMatchEnd(match);
				}
				else
				{
					match.IsComplete = false;
					callback.OnRoundStart(match);
				}
			}
			else
			{
				callback.OnFrameStart(match);
				callback.OnFrameUpdate(match);
				callback.OnFrameEnd(match);
			}
		}
		
		private var settings : TournamentSettings
		private var callback : MatchCallback;
		private var player1 : Player;
		private var player2 : Player;
		private var level : Level;
		private var match : Match;		
	}
	
}
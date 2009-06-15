package fighter.controller.callback
{
	import fighter.model.game.Game;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	import fighter.model.tournament.TournamentEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class TournamentCallbackImpl extends EventDispatcher implements TournamentCallback
	{
		
		public function OnTournamentStart(tournament:Tournament):void
		{
			tournament.Games = new Vector.<Game>();
			var level : Level = new Level(new Sprite(), new Sprite());
			var gameCallback : GameCallback = new GameCallbackImpl();
			
			for(var i : int = 0; i < tournament.Players.length; i++)
			{
				var currentPlayer : Player = tournament.Players[i];
				if( currentPlayer !== tournament.TopPlayer )
				{
					tournament.Games.push( new Game( currentPlayer, tournament.TopPlayer, level, gameCallback ) );
				}
			}
			
			tournament.CurrentGame = tournament.Games[0];
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			this.dispatchEvent(new TournamentEvent(tournament, TournamentEvent.TOURNAMENT_OVER));
		}
		
		public function OnTournamentUpdate(tournament:Tournament, game:Game):void
		{
			tournament.CurrentGame.Callback.OnFrameUpdate( tournament.CurrentGame );
		}
		
		public function OnTournamentGameEnd(tournament:Tournament, game:Game):void
		{
			dispatchEvent(new TournamentEvent(tournament, TournamentEvent.TOURNAMENT_OVER));
		}
		 
	}
}
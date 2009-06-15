package fighter.controller.callback
{
	import fighter.model.game.Game;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class TournamentCallbackImpl extends EventDispatcher implements TournamentCallback
	{
		
		public function OnTournamentStart(tournament:Tournament):void
		{
			tournament.Games = new Vector.<Game>();
			var level : Level = new Level(new Sprite(), new Sprite());
			
			for(var i : int = 0; i < tournament.Players.length; i++)
			{
				var currentPlayer : Player = tournament.Players[i];
				if( currentPlayer !== tournament.TopPlayer )
				{
					tournament.Games.push( new Game( currentPlayer, tournament.TopPlayer, level, new GameCallbackImpl() ) );
				}
			}
			
			tournament.CurrentGame = tournament.Games[0];
			
			tournament.CurrentGame.Callback.OnGameStart( tournament.CurrentGame );
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			
		}
		
		public function OnTournamentUpdate(tournament:Tournament, game:Game):void
		{
			tournament.CurrentGame.Callback.OnFrameUpdate( tournament.CurrentGame );
			if(tournament.CurrentGame.IsComplete)
			{
				if(game.Player1.Health <= 0 && game.Player2.Health <= 0)
				{
					game.Player1.PlayerSpecimen.Data["draws"] = game.Player1.PlayerSpecimen.Data["draws"] + 1;
					game.Player2.PlayerSpecimen.Data["draws"] = game.Player2.PlayerSpecimen.Data["draws"] + 1;
				}
				else if(game.Player1.Health <= 0)
				{
					game.Player1.PlayerSpecimen.Data["losses"] = game.Player1.PlayerSpecimen.Data["losses"] + 1;
					game.Player2.PlayerSpecimen.Data["wins"] = game.Player2.PlayerSpecimen.Data["wins"] + 1;
				}
				else if(game.Player2.Health <= 0)
				{
					game.Player1.PlayerSpecimen.Data["wins"] = game.Player1.PlayerSpecimen.Data["wins"] + 1;
					game.Player2.PlayerSpecimen.Data["losses"] = game.Player2.PlayerSpecimen.Data["losses"] + 1;
				}
			}
		}
		
		public function OnTournamentGameEnd(tournament:Tournament, game:Game):void
		{
			
		}
		 
	}
}
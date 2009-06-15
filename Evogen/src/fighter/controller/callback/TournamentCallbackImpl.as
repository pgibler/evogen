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
			GenerateGameAndSetAsCurrent(tournament.TopPlayer, tournament.Players[1], tournament);
			tournament.CurrentGame.Callback.OnGameStart( tournament.CurrentGame );
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			trace("Tournament complete");
		}
		
		public function OnTournamentUpdate(tournament:Tournament, game:Game):void
		{
			tournament.CurrentGame.Callback.OnFrameUpdate( tournament.CurrentGame );
			if(tournament.CurrentGame.IsComplete)
			{
				OnTournamentGameEnd( tournament, game );
			}
		}
		
		public function OnTournamentGameEnd(tournament:Tournament, game:Game):void
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
				
				tournament.TopPlayer = game.Player2;
			}
			else if(game.Player2.Health <= 0)
			{
				game.Player1.PlayerSpecimen.Data["wins"] = game.Player1.PlayerSpecimen.Data["wins"] + 1;
				game.Player2.PlayerSpecimen.Data["losses"] = game.Player2.PlayerSpecimen.Data["losses"] + 1;
				
				tournament.TopPlayer = game.Player1;
			}
			
			GenerateGameAndSetAsCurrent(tournament.TopPlayer, tournament.NextPlayer, tournament);
		}
		
		private function GenerateGameAndSetAsCurrent(player1:Player, player2:Player, tournament:Tournament):Game
		{
			var level : Level = new Level(new Sprite(), new Sprite());
			var game : Game = new Game( player1, player2, level, new GameCallbackImpl() );
			tournament.Games.push(game);
			tournament.CurrentGame = game;
			return game;
		}
		 
	}
}
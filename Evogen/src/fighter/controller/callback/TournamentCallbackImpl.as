package fighter.controller.callback
{
	import fighter.model.game.DefaultLevel;
	import fighter.model.game.Game;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	
	import flash.events.EventDispatcher;
	
	public class TournamentCallbackImpl extends EventDispatcher implements TournamentCallback
	{
		
		public function OnTournamentStart(tournament:Tournament):void
		{
			for each(var p : Player in tournament.Players)
			{
				p.BreedableSpecimen.Data["wins"] = 0;
				p.BreedableSpecimen.Data["losses"] = 0;
			}
			
			GenerateGameAndSetAsCurrent(tournament.TopPlayer, tournament.NextPlayer, tournament);
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			trace("Tournament complete. " + tournament.Games.length + " games played.");
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
			var winner : Player = game.Player1.Health >= game.Player2.Health ? game.Player1 : game.Player2;
			var loser : Player = winner.CurrentOpponent;
			
			winner.BreedableSpecimen.Data["wins"] = tournament.TopPlayer.BreedableSpecimen.Data["wins"] + 1;
			loser.BreedableSpecimen.Data["losses"] += 1;
			
			var nextPlayer : Player = tournament.NextPlayer;
			
			if(!tournament.IsComplete)
			{
				GenerateGameAndSetAsCurrent(winner, nextPlayer, tournament);
			}
			else
			{
				OnTournamentEnd(tournament);
			}
		}
		
		private function GenerateGameAndSetAsCurrent(player1:Player, player2:Player, tournament:Tournament):Game
		{
			var level : Level = new DefaultLevel();
			var game : Game = new Game( player1, player2, level, new GameCallbackImpl(), tournament.TournamentGameSettings );
			tournament.Games.push(game);
			tournament.CurrentGame = game;
			tournament.CurrentGame.Callback.OnGameStart(tournament.CurrentGame);
			return game;
		}
		 
	}
}
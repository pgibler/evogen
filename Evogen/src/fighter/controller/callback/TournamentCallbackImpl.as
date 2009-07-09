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
				p.BreedableSpecimen.Data["Wins"] = 0;
				p.BreedableSpecimen.Data["Losses"] = 0;
				p.BreedableSpecimen.Data["TotalDamageDealt"] = 0;
				p.BreedableSpecimen.Data["TotalSuccessfulBlocks"] = 0;
				p.BreedableSpecimen.Data["GamesPlayed"] = 0;
				p.BreedableSpecimen.Data["BlockTest"] = false;
			}
			
			GenerateGameAndSetAsCurrent(tournament.TopPlayer, tournament.NextPlayer, tournament);
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			for each(var p : Player in tournament.Players)
			{
				p.BreedableSpecimen.Data["AverageDamageDealt"] = p.BreedableSpecimen.Data["TotalDamageDealt"] / p.BreedableSpecimen.Data["GamesPlayed"];
				p.BreedableSpecimen.Data["AverageSuccessfulBlocks"] = p.BreedableSpecimen.Data["TotalSuccessfulBlocks"] / p.BreedableSpecimen.Data["GamesPlayed"];
			}
			
			trace("Tournament complete. " + tournament.Games.length + " games played.");
		}
		
		public function OnTournamentUpdate(tournament:Tournament, game:Game):void
		{
			if(!tournament.CurrentGame.IsComplete)
			{
				tournament.CurrentGame.Callback.OnFrameUpdate( tournament.CurrentGame );
			}
			else
			{
				OnTournamentGameEnd( tournament, game );
			}
		}
		
		public function OnTournamentGameEnd(tournament:Tournament, game:Game):void
		{
			var winner : Player = game.Player1.Health >= game.Player2.Health ? game.Player1 : game.Player2;
			var loser : Player = winner.CurrentOpponent;
			
			winner.BreedableSpecimen.Data["Wins"] = winner.BreedableSpecimen.Data["Wins"] + 1;
			loser.BreedableSpecimen.Data["Losses"] += 1;
			
			winner.BreedableSpecimen.Data["TotalDamageDealt"] += loser.HealthMax - loser.Health;
			winner.BreedableSpecimen.Data["GamesPlayed"] += 1;
			loser.BreedableSpecimen.Data["TotalDamageDealt"] += winner.HealthMax - winner.Health;
			loser.BreedableSpecimen.Data["GamesPlayed"] += 1;
			
			var nextPlayer : Player = tournament.NextPlayer;
			tournament.TopPlayer = winner;
			
			if(!tournament.IsComplete)
			{
				GenerateGameAndSetAsCurrent(tournament.TopPlayer, nextPlayer, tournament);
			}
			else
			{
				OnTournamentEnd(tournament);
			}
		}
		
		private function GenerateGameAndSetAsCurrent(player1:Player, player2:Player, tournament:Tournament):Game
		{
			if(	tournament.CurrentGame != null &&
				tournament.CurrentGame.Settings.GamePlayContainer.contains(tournament.CurrentGame.DisplayContainer))
			{
				tournament.CurrentGame.Settings.GamePlayContainer.removeChild(tournament.CurrentGame.DisplayContainer);
			}
			var level : Level = new DefaultLevel();
			var game : Game = new Game( player1, player2, level, new GameCallbackImpl(), tournament.TournamentGameSettings );
			tournament.Games.push(game);
			tournament.CurrentGame = game;
			game.Callback.OnGameStart(tournament.CurrentGame);
			game.Settings.GamePlayContainer.addChild(tournament.CurrentGame.DisplayContainer);
			return game;
		}
		 
	}
}
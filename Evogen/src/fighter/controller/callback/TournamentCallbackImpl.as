package fighter.controller.callback
{
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.player.production.ProductionTemplate;
	import fighter.model.game.Game;
	import fighter.model.game.GameEvent;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	import fighter.model.tournament.TournamentEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class TournamentCallbackImpl  extends EventDispatcher implements TournamentCallback
	{
		
		public function OnTournamentStart(tournament:Tournament):void
		{
			if(tournament.Players == null)
			{
				tournament.Players = new Vector.<Player>();
				var i : int;
				for(i = 0; i < tournament.PopulationSize; i++)
				{
					var prodTemp : ProductionTemplate = new ComputerProductionTemplate();
					var prod : Production = prodTemp.GenerateProduction();
					var cont : PlayerController = new PlayerController( prod );
					tournament.Players.push( new Player(cont) );
				}
				
				tournament.TopPlayer = tournament.Players[0];
				tournament.Games = new Vector.<Game>();
				var level : Level = new Level(new Sprite(), new Sprite());
				
				for(i = 0; i < tournament.Players.length; i++)
				{
					var currentPlayer : Player = tournament.Players[i];
					if( currentPlayer !== tournament.TopPlayer )
					{
						tournament.Games.push( new Game( currentPlayer, tournament.TopPlayer, level ) );
					}
				}
				
				tournament.CurrentGame = tournament.Games[0];
				
			}
			else
			{
				// Repopulate
				
			}
		}
		
		public function OnTournamentEnd(tournament:Tournament):void
		{
			this.dispatchEvent(new TournamentEvent(tournament, TournamentEvent.TOURNAMENT_OVER));
		}
		
		public function OnTournamentGameStart(tournament:Tournament, game:Game):void
		{
		}
		
		public function OnTournamentGameEnd(tournament:Tournament, game:Game):void
		{
			dispatchEvent(new TournamentEvent(tournament, TournamentEvent.TOURNAMENT_OVER));
		}
		 
	}
}
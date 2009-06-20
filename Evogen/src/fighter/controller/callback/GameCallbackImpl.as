package fighter.controller.callback 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameCallbackImpl implements GameCallback
	{
		
		/* INTERFACE fighter.controller.callback.GameCallback */
		
		public function OnFrameUpdate(game:Game):void
		{
			if (game.IsComplete)
			{
				OnGameEnd(game);
			}
			else
			{
				var p1 : Player = game.Player1;
				var p2 : Player = game.Player2;
				p1.Controller.Update(p1, game);
				p2.Controller.Update(p2, game);
				game.TimeElapsed += 1;
				trace("Game time: left="+game.TimeElapsed + ", max=" + game.TimeMax);
			}
		}
		
		public function OnGameStart(game:Game):void
		{
			game.Player1.Initialize();
			game.Player2.Initialize();
			
			var startPos1 : Point = game.StartingPositions[0];
			var startPos2 : Point = game.StartingPositions[1];
			
			if (Math.random() >= .5)
			{
				game.Player1.Position = startPos1;
				game.Player2.Position = startPos2;
			}
			else
			{
				game.Player1.Position = startPos2;
				game.Player2.Position = startPos1;
			}
			
			game.Player1.CurrentGame = game;
			game.Player2.CurrentGame = game;
			game.Player1.CurrentOpponent = game.Player2;
			game.Player2.CurrentOpponent = game.Player1;
		}
		
		public function OnGameEnd(game:Game):void
		{
			trace("Game ended");
		}
		
	}
	
}
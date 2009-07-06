package fighter.controller.callback 
{
	import fighter.controller.player.action.AirStunnedAction;
	import fighter.controller.player.action.GroundStunnedAction;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.GameInterface;
	
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
			for(var i : int = 0; i < game.Settings.FrameIntervalsPerTick; i++)
			{
				if (game.IsComplete)
				{
					OnGameEnd(game);
					break;
				}
				else
				{
					var p1 : Player = game.Player1;
					var p2 : Player = game.Player2;
					p1.Controller.Update(p1, game);
					p2.Controller.Update(p2, game);
					game.TimeElapsed += 1;
					//trace("Game time: left="+game.TimeElapsed + ", max=" + game.TimeMax + ", p1 hp:"+p1.Health + ", p2 hp:"+p2.Health);
					
					if(game.Settings.Mode == Game.GRAPHICAL)
					{
						if(!gameOnScreen)
						{
							if(gi == null)
								gi = new GameInterface();
							game.Settings.DisplayContainer.addChild(game.Settings.GameContainer);
							game.Settings.GameInterfaceContainer.addChild(gi);
							game.Settings.GamePlayContainer.addChild(game.DisplayContainer);
							game.Settings.GameContainer.x = game.GameLevel.Ground.width/2;
							game.Settings.GameContainer.y = game.GameLevel.Ground.height*2.5;
							gameOnScreen = true;
						}
						gi.Update(game);
					}
					else if(gameOnScreen)
					{
						game.Settings.DisplayContainer.removeChild(game.Settings.GameContainer);
						game.Settings.GameInterfaceContainer.removeChild(gi);
						game.Settings.GamePlayContainer.removeChild(game.DisplayContainer);
						gameOnScreen = false;
					}
				}
			}
		}
		
		public function OnGameStart(game:Game):void
		{
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
			game.TimeElapsed = 0;
			
			game.Player1.Initialize(game);
			game.Player2.Initialize(game);
			
			game.DisplayContainer.addChild(game.GameLevel.Background);
			game.DisplayContainer.addChild(game.GameLevel.Ground);
			game.DisplayContainer.addChild(game.Player1.DisplayContainer);
			game.DisplayContainer.addChild(game.Player2.DisplayContainer);
			
			if(game.Settings.Mode == Game.GRAPHICAL)
			{
				game.Settings.DisplayContainer.addChild(game.Settings.GameContainer);
				game.Settings.GamePlayContainer.addChild(game.DisplayContainer);
				game.Settings.GameContainer.x = game.GameLevel.Ground.width/2;
				game.Settings.GameContainer.y = game.GameLevel.Ground.height*2.5;
				
				gameOnScreen = true;
				gi = new GameInterface();
				game.Settings.GameInterfaceContainer.addChild(gi);
			}
		}
		
		public function OnGameEnd(game:Game):void
		{
			if(game.Settings.Mode == Game.GRAPHICAL)
			{
				game.Settings.DisplayContainer.removeChild(game.Settings.GameContainer);
				game.Settings.GameInterfaceContainer.removeChild(gi);
				game.Settings.GamePlayContainer.removeChild(game.DisplayContainer);
			}
			
			game.DisplayContainer.removeChild(game.GameLevel.Background);
			game.DisplayContainer.removeChild(game.GameLevel.Ground);
			game.DisplayContainer.removeChild(game.Player1.DisplayContainer);
			game.DisplayContainer.removeChild(game.Player2.DisplayContainer);
		}
		
		private var gameOnScreen : Boolean = false;
		private var gi : GameInterface;
		
	}
	
}
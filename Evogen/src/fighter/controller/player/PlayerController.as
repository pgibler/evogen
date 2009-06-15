package fighter.controller.player 
{
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import fighter.model.game.Game;
	import fighter.controller.player.action.Action;
	import fighter.controller.player.production.Production;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class PlayerController
	{
		
		public function PlayerController(rules:Production) 
		{
			this.rules = rules;
		}
		
		public function Update(player:Player, game:Game):PlayerController 
		{
			if (lag <= 0)
			{
				var conditionString : String = "";
				for (var i : int = 0; i < rules.Conditions.length; i++)
				{
					conditionString += int(rules.Conditions[i].EvaluateCondition(player, game));
				}
				var a : Action = rules.SelectAction(conditionString);
				if (a != null && a.IsValid(player, game))
				{
					a.PerformAction(player, game);
					lag = a.FrameLag;
				}
			}
			else
			{
				lag--;
			}
			
			if (player.Position.y < game.GameLevel.GroundY)
			{
				player.YSpeed += player.Gravity;
			}
			player.XSpeed *= player.Friction;
			player.Position.y += player.YSpeed;
			if (player.XSpeed > 0)
			{
				player.Position.x = Math.min(player.Position.x + player.XSpeed, game.GameLevel.RightWallX);
			}
			else if (player.XSpeed > 0)
			{
				player.Position.x = Math.max(player.Position.x - player.XSpeed, game.GameLevel.LeftWallX);
			}
			return this;
		}
		
		private var lag : int;
		private var rules : Production;
		
	}
	
}
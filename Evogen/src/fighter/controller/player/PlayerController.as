package fighter.controller.player 
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.action.GroundIdleAction;
	import fighter.controller.player.production.Production;
	import fighter.model.game.Game;
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
		
		public function Initialize(player:Player, game:Game):PlayerController
		{
			new GroundIdleAction().PerformAction(player, game);
			return this;
		}
		
		public function Update(player:Player, game:Game):PlayerController 
		{
			trace("Player position: " + player.Position);
			if (lag <= 0)
			{
				var conditionString : String = "";
				for (var i : int = 0; i < rules.Conditions.length; i++)
				{
					conditionString += int(rules.Conditions[i].EvaluateCondition(player, game));
				}
				player.CurrentAction = rules.SelectAction(conditionString);
				var a : Action = player.CurrentAction;
				if (a != null && a.IsValid(player, game))
				{
					a.PerformAction(player, game);
					trace("Player " + player + " is performing action " + a.Name);
					lag = a.FrameLag;
				}
			}
			else
			{
				lag--;
				if(lag <= 0 && player.CurrentAction != null)
				{
					player.CurrentAction.OnComplete(player, game);
				}
			}
			
			player.XSpeed *= player.Friction;
			player.Position.y += player.YSpeed;
			trace(player.YSpeed);
			
			if (player.Position.y < game.GameLevel.GroundY)
			{
				player.YSpeed += player.Gravity;
			}
			else if(player.Position.y > game.GameLevel.GroundY)
			{
				player.YSpeed = 0;
				player.Position.y = game.GameLevel.GroundY;
			}
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
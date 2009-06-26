﻿package fighter.controller.player 
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.action.AirStunnedAction;
	import fighter.controller.player.action.GroundStunnedAnimation;
	import fighter.controller.player.production.Production;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.display.DisplayObject;
	
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
			return this;
		}
		
		public function Update(player:Player, game:Game):PlayerController 
		{
			//trace("Player position: " + player.Position);
			
			var oppDmgBox : DisplayObject = player.CurrentOpponent.CurrentAnimation.getChildByName("DamageBox");
			var hitBox : DisplayObject = player.CurrentAnimation.getChildByName("HitBox");
			if(!player.IsStunned && oppDmgBox != null && hitBox != null)
			{
				if(oppDmgBox.hitTestObject(hitBox))
				{
					player.Health -= player.CurrentOpponent.HitDamage;
					if(player.OnGround)
					{ 
						player.CurrentAction = new GroundStunnedAnimation();
					} 
					else
					{
						player.CurrentAction = new AirStunnedAction();
					}
					player.CurrentAction.PerformAction(player,game);
				}
			}
			
			if (player.FrameLag <= 0)
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
					//trace("Player " + player + " is performing action " + a.Name);
					player.FrameLag = a.FrameLag;
				}
			}
			else
			{
				player.FrameLag--;
				if(player.FrameLag <= 0)
				{
					player.CurrentAction.OnComplete(player, game);
				}
			}
			
			player.Position.y += player.YSpeed;
			if(player.OnGround && player.IsIdle)
			{
				player.FacePlayer(player.CurrentOpponent);
				player.XSpeed = 0;
			}
			
			if (player.Position.y < game.GameLevel.GroundY)
			{
				player.YSpeed += player.Gravity;
			}
			else if(player.Position.y > game.GameLevel.GroundY)
			{
				player.YSpeed = 0;
				player.Position.y = game.GameLevel.GroundY;
			}
			var widthover2 : Number = player.DisplayContainer.width/2;
			player.Position.x += player.XSpeed;
			if (player.XSpeed > 0)
			{
				player.Position.x = Math.min(player.Position.x, game.GameLevel.RightWallX - widthover2);
			}
			else if (player.XSpeed < 0)
			{
				player.Position.x = Math.max(player.Position.x, game.GameLevel.LeftWallX + widthover2);
			}
			player.DisplayContainer.x = player.Position.x;
			player.DisplayContainer.y = player.Position.y;
			return this;
		}
		
		private var rules : Production;
		
	}
	
}
﻿package fighter.controller.player 
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.action.AirStunnedAction;
	import fighter.controller.player.action.GroundStunnedAction;
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
			if(player.RunAnimation)
			{
				player.CurrentAnimation.nextFrame();
			}
			
			var opp : Player = player.CurrentOpponent;
			
			var oppDmgBox : DisplayObject = opp.CurrentAnimation.getChildByName("DamageBox");
			var hitBox : DisplayObject = player.CurrentAnimation.getChildByName("HitBox");
			if(!player.IsStunned && oppDmgBox != null && hitBox != null)
			{
				if(oppDmgBox.hitTestObject(hitBox))
				{
					if(!player.IsBlocking)
					{
						player.Health -= opp.HitDamage;
						if(player.OnGround)
						{
							player.CurrentAction = new GroundStunnedAction();
						}
						else
						{
							player.CurrentAction = new AirStunnedAction();
						}
						player.CurrentAction.PerformAction(player,game);
					}
				}
			}
			
			var oppHitBox : DisplayObject = opp.CurrentAnimation.getChildByName("HitBox");
			var widthover2 : Number = player.DisplayContainer.width/2;
			
			if(hitBox != null && oppHitBox != null)
			{
				if(hitBox.hitTestObject(oppHitBox))
				{
					var currX : Number = player.Position.x;
					if(opp.Position.x > currX)
					{
						player.Position.x = Math.max(currX - player.SeparationSpeed, game.GameLevel.LeftWallX+widthover2);
					}
					else if(opp.Position.x < player.Position.x)
					{
						player.Position.x = Math.min(currX + player.SeparationSpeed, game.GameLevel.RightWallX-widthover2);
					}
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
				//trace("lag left:"+player.FrameLag);
				player.FrameLag--;
				if(player.FrameLag <= 0)
				{
					player.CurrentAction.OnComplete(player, game);
				}
			}
			
			if(player.OnGround && player.IsIdle)
			{
				player.FacePlayer(player.CurrentOpponent);
				player.XSpeed = 0;
			}
			
			player.Position.y += player.YSpeed;
			
			if (player.Position.y < game.GameLevel.GroundY)
			{
				player.YSpeed += player.Gravity;
			}
			else if(player.Position.y > game.GameLevel.GroundY)
			{
				player.YSpeed = 0;
				player.Position.y = game.GameLevel.GroundY;
			}
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
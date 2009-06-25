﻿package fighter.controller.player.condition 
{
	import fighter.controller.player.action.*;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class IsOnGroundCondition implements Condition
	{
		
		public function IsOnGroundCondition()
		{
			possibleActionsWhenTrue = new Vector.<Action>();

			possibleActionsWhenTrue.push(new GroundIdleAction());
			possibleActionsWhenTrue.push(new GroundMediumPunchAction());
			possibleActionsWhenTrue.push(new BlockAction());
			possibleActionsWhenTrue.push(new JumpUpAction());
			possibleActionsWhenTrue.push(new JumpLeftAction());
			possibleActionsWhenTrue.push(new JumpRightAction());
			possibleActionsWhenTrue.push(new MoveLeftAction());
			possibleActionsWhenTrue.push(new MoveRightAction());			
			
			possibleActionsWhenFalse = AvailableActions.GetAllActionsExcluding(possibleActionsWhenTrue);
			
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return player.OnGround;
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function get PossibleActionsWhenTrue():Vector.<Action>
		{
			return possibleActionsWhenTrue;
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Action>
		{
			return possibleActionsWhenFalse;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
		private var possibleActionsWhenTrue : Vector.<Action>;
		private var possibleActionsWhenFalse : Vector.<Action>;
		
	}
	
}
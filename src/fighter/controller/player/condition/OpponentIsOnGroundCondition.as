﻿package fighter.model.player.condition 
{
	import flash.utils.getQualifiedClassName;
	import fighter.model.player.action.Action;
	import fighter.model.player.action.AvailableActions;
	import fighter.model.player.Player;
	import fighter.model.fighter.Game;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class OpponentIsOnGroundCondition implements Condition
	{
		
		public function OpponentIsOnGroundCondition()
		{
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return player.CurrentOpponent.OnGround;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function get PossibleActionsWhenTrue():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		private var name : String;
		
	}
	
}
package fighter.controller.player.condition 
{
	import fighter.controller.player.action.*;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class IsToLeftOfOpponentCondition implements Condition
	{
		
		public function IsToLeftOfOpponentCondition()
		{
			possibleActionsWhenTrue = AvailableActions.GetAllActions();
			possibleActionsWhenFalse = AvailableActions.GetAllActions();
			
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return player.Position.x < player.CurrentOpponent.Position.x;
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
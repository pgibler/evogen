package fighter.controller.player.condition 
{
	import fighter.controller.player.action.AvailableActions;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	import fighter.model.game.Game;
	import fighter.controller.player.action.*;
	import fighter.model.player.Player;
	import fighter.util.KeyObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class LeftKeyDownCondition implements Condition
	{
		
		public function LeftKeyDownCondition()
		{
			this.name = getQualifiedClassName(this);
			this.possibleActionsWhenTrue = new Vector.<Action>();
			
			possibleActionsWhenTrue.push(new JumpLeftAction());
			possibleActionsWhenTrue.push(new MoveLeftAction());
			
			possibleActionsWhenFalse = AvailableActions.GetAllActionsExcluding(possibleActionsWhenTrue);
		}
		
		/* INTERFACE fighter.controller.player.condition.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return KeyObject.instance.isDown(Keyboard.LEFT);
		}
		
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
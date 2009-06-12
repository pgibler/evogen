package fighter.controller.player.condition 
{
	import fighter.controller.player.action.AvailableActions;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	import fighter.model.game.Game;
	import fighter.controller.player.action.Action;
	import fighter.controller.player.action.AirKickAction;
	import fighter.controller.player.action.GroundKickAction;
	import fighter.controller.player.action.JumpAwayAction;
	import fighter.controller.player.action.JumpTowardsAction;
	import fighter.controller.player.action.MoveAwayAction;
	import fighter.controller.player.action.MoveTowardsAction;
	import fighter.model.player.Player;
	import fighter.util.KeyObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class RightKeyDownCondition implements Condition
	{
		
		public function RightKeyDownCondition()
		{
			super();
			this.name = getQualifiedClassName(this);
			
			this.possibleActionsWhenTrue = new Vector.<Action>();
			
			possibleActionsWhenTrue.push(new JumpAwayAction());
			possibleActionsWhenTrue.push(new JumpTowardsAction());
			possibleActionsWhenTrue.push(new MoveAwayAction());
			possibleActionsWhenTrue.push(new MoveTowardsAction());
			
			possibleActionsWhenFalse = AvailableActions.GetAllActionsExcluding( possibleActionsWhenTrue );
		}
		
		/* INTERFACE fighter.controller.player.condition.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			var keyDown : Boolean = KeyObject.instance.isDown(Keyboard.RIGHT);
			return keyDown;
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
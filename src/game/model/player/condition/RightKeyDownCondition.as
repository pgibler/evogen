package game.model.player.condition 
{
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	import game.model.match.Match;
	import game.model.player.action.Action;
	import game.model.player.action.AirKickAction;
	import game.model.player.action.GroundKickAction;
	import game.model.player.action.JumpAwayAction;
	import game.model.player.action.JumpTowardsAction;
	import game.model.player.action.MoveAwayAction;
	import game.model.player.action.MoveTowardsAction;
	import game.model.player.Player;
	import game.util.KeyObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class RightKeyDownCondition implements Condition
	{
		
		public function RightKeyDownCondition()
		{
			this.name = getQualifiedClassName(this);
			
			possibleActionsWhenTrue.push(new AirKickAction());
			possibleActionsWhenTrue.push(new GroundKickAction());
			possibleActionsWhenTrue.push(new MoveTowardsAction());
			possibleActionsWhenTrue.push(new MoveAwayAction());
			possibleActionsWhenTrue.push(new JumpTowardsAction());
			possibleActionsWhenTrue.push(new JumpAwayAction());
			
			possibleActionsWhenFalse = possibleActionsWhenTrue
		}
		
		/* INTERFACE game.model.player.condition.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return KeyObject.instance.isDown(Keyboard.RIGHT);
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
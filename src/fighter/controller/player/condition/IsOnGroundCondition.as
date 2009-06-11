package fighter.controller.player.condition 
{
	import flash.utils.getQualifiedClassName;
	import fighter.controller.player.action.AvailableActions;
	import fighter.model.player.Player;
	import fighter.model.fighter.Game;
	import fighter.controller.player.action.*;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class IsOnGroundCondition implements Condition
	{
		
		public function IsOnGroundCondition()
		{
			possibleActionsWhenTrue = new Vector.<Action>();
			possibleActionsWhenFalse = new Vector.<Action>();
			
			possibleActionsWhenTrue.push(new GroundIdleAction());
			possibleActionsWhenTrue.push(new GroundKickAction());
			possibleActionsWhenTrue.push(new BlockAction());
			possibleActionsWhenTrue.push(new JumpAwayAction());
			possibleActionsWhenTrue.push(new JumpTowardsAction());
			possibleActionsWhenTrue.push(new JumpUpAction());
			possibleActionsWhenTrue.push(new MoveAwayAction());
			possibleActionsWhenTrue.push(new MoveTowardsAction());
			
			possibleActionsWhenFalse.push(new AirIdleAction());
			possibleActionsWhenFalse.push(new AirKickAction());
			
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
		
		private var name : String;
		private var possibleActionsWhenTrue : Vector.<Action>;
		private var possibleActionsWhenFalse : Vector.<Action>;
		
	}
	
}
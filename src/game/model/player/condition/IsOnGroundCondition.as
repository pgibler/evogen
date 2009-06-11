package game.model.player.condition 
{
	import flash.utils.getQualifiedClassName;
	import game.model.player.action.AvailableActions;
	import game.model.player.Player;
	import game.model.match.Match;
	import game.model.player.action.*;
	
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
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return player.OnGround;
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
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
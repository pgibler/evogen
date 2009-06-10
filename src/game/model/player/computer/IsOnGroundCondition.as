package game.model.player.computer 
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
			possibleActionsWhenTrue = new Vector.<Class>();
			possibleActionsWhenFalse = new Vector.<Class>();
			
			possibleActionsWhenTrue.push(GroundKickAction);
			possibleActionsWhenTrue.push(GroundPunchAction);
			possibleActionsWhenTrue.push(JumpAwayAction);
			possibleActionsWhenTrue.push(JumpTowardsAction);
			possibleActionsWhenTrue.push(JumpUpAction);
			possibleActionsWhenTrue.push(MoveAwayAction);
			possibleActionsWhenTrue.push(MoveTowardsAction);
			
			possibleActionsWhenFalse.push(AirKickAction);
			possibleActionsWhenFalse.push(AirPunchAction);
			
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return player.OnGround;
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function get PossibleActionsWhenTrue():Vector.<Class>
		{
			return possibleActionsWhenTrue;
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Class>
		{
			return possibleActionsWhenFalse;
		}
		
		private var name : String;
		private var possibleActionsWhenTrue : Vector.<Class>;
		private var possibleActionsWhenFalse : Vector.<Class>;
		
	}
	
}
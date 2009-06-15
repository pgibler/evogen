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
	public class IsOpponentToMyLeftCondition implements Condition
	{
		
		public function IsOnGroundCondition()
		{
			possibleActionsWhenTrue = new Vector.<Action>();
			possibleActionsWhenFalse = new Vector.<Action>();
			
			possibleActionsWhenTrue.push(new GroundIdleAction());
			possibleActionsWhenTrue.push(new GroundKickAction());
			possibleActionsWhenTrue.push(new BlockAction());
			possibleActionsWhenTrue.push(new JumpLeftCondition());
			possibleActionsWhenTrue.push(new JumpRightCondition());
			possibleActionsWhenTrue.push(new JumpUpAction());
			possibleActionsWhenTrue.push(new MoveLeftCondition());
			possibleActionsWhenTrue.push(new MoveRightCondition());
			
			possibleActionsWhenFalse.push(new AirIdleAction());
			possibleActionsWhenFalse.push(new AirKickAction());
			
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return player.x > player.CurrentOpponent.x;
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
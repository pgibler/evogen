package fighter.controller.player.condition 
{
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
	public class KickKeyDownCondition implements Condition
	{
		
		public function KickKeyDownCondition()
		{
			super();
			this.name = getQualifiedClassName(this);
			
			possibleActionsWhenTrue = new Vector.<Action>();
			
			possibleActionsWhenTrue.push(new AirMediumPunchAction());
			possibleActionsWhenTrue.push(new GroundMediumPunchAction());
			
			possibleActionsWhenFalse = AvailableActions.GetAllActionsExcluding(possibleActionsWhenTrue);
		}
		
		/* INTERFACE fighter.controller.player.condition.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return KeyObject.instance.isDown(83);
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
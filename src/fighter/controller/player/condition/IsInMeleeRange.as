package fighter.controller.player.condition 
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.action.AvailableActions;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class IsInMeleeRange implements Condition
	{
		
		public function IsInMeleeRange() 
		{
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			var p : Point = player.Position.clone();
			p.y -= player.DisplayContainer.height/2;
			var o : Point = player.CurrentOpponent.Position.clone();
			o.y -= player.CurrentOpponent.DisplayContainer.height/2;
			var dist : Number = Point.distance(o,p);
			return dist < 100;
		}
		
		public function get PossibleActionsWhenTrue():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
		
	}
	
}
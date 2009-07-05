﻿package fighter.controller.player.action 
{
	
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class AvailableActions 
	{
		
		private static var returnme : Vector.<Action>;
		
		public static function GetAllActions():Vector.<Action>
		{
			if (returnme == null)
			{
				returnme = new Vector.<Action>();
				returnme.push(new JumpTowardAction());
				returnme.push(new JumpUpAction());
				returnme.push(new JumpAwayAction());
				returnme.push(new MoveTowardAction());
				returnme.push(new MoveAwayAction());
				returnme.push(new GroundMediumPunchAction());
				returnme.push(new AirMediumPunchAction());
				returnme.push(new BlockAction());
				
				returnme.push(new AirIdleAction());
				returnme.push(new GroundIdleAction());
			}
			return returnme;
		}
		
		public static function GetAllActionsExcluding(excluded : Vector.<Action>):Vector.<Action>
		{
			var excludedNames : Vector.<String> = new Vector.<String>();
			excluded.forEach(function(a:Action, index:int, vector:Vector.<Action>):void
			{
				excludedNames.push(a.Name);
			});
			
			var all : Vector.<Action> = GetAllActions();
			
			all = all.filter(function(a:Action, index:int, vector:Vector.<Action>):Boolean
			{
				return excludedNames.indexOf(a.Name) == -1;
			});
			return all;
		}
		
	}
	
}
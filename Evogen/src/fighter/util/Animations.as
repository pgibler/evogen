package fighter.util
{
	import flash.display.MovieClip;

	public class Animations
	{
		
		private static var instance : Animations;
		
		public static function get Instance():Animations
		{
			if(instance == null)
			{
				Initialize();
			}
			return instance;
		}
		
		public static function Initialize():void
		{
			instance = new Animations();
			CammyAirIdle = new CammyAirIdleClass();
			CammyBlock = new CammyBlockClass();
			CammyGroundIdle = new CammyGroundIdleClass();
			CammyGroundPunch = new CammyGroundPunchClass();
			CammyJumpLeft = new CammyJumpLeftClass();
			CammyJumpRight = new CammyJumpRightClass();
			CammyJumpUp = new CammyJumpUpClass();
			CammyWalkBackward = new CammyWalkBackwardClass();
			CammyWalkToward = new CammyWalkTowardClass();
		}
		
		public var CammyAirIdle : MovieClip;
		public var CammyGroundIdle : MovieClip;
		public var CammyBlock : MovieClip;
		public var CammyJumpBackward : MovieClip;
		public var CammyJumpToward : MovieClip;
		public var CammyJumpUp : MovieClip;
		public var CammyWalkBackward : MovieClip;
		public var CammyWalkToward : MovieClip;
		
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyAirIdle')]
		public var CammyAirIdleClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyGroundIdle')]
		public var CammyGroundIdleClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyBlock')]
		public var CammyBlockClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyGroundPunch')]
		public var CammyGroundPunchClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpBackward')]
		public var CammyJumpBackwardClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpToward')]
		public var CammyJumpTowardClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpUp')]
		public var CammyJumpUpClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkToward')]
		public var CammyWalkTowardClass : Class;
		[Embed(source='../../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkBackward')]
		public var CammyWalkBackwardClass : Class;
		
		
		public function Animations(se:SingletonEnforcer)
		{
		}
		
	}
}

internal class SingletonEnforcer { }
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
			instance = new Animations(new SingletonEnforcer());
			instance.CammyBlock = new instance.CammyBlockClass();
			instance.CammyIdle = new instance.CammyIdleClass();
			instance.CammyGroundMediumPunch = new instance.CammyGroundMediumPunchClass();
			instance.CammyAirMediumPunch = new instance.CammyAirMediumPunchClass();
			instance.CammyJumpBackward = new instance.CammyJumpBackwardClass();
			instance.CammyJumpForward = new instance.CammyJumpForwardClass();
			instance.CammyJumpUp = new instance.CammyJumpUpClass();
			instance.CammyWalkBackward = new instance.CammyWalkBackwardClass();
			instance.CammyWalkToward = new instance.CammyWalkTowardClass();
			instance.CammyStunned = new instance.CammyStunnedClass();
			instance.CammyIntro = new instance.CammyIntroClass();
			instance.CammyVictory = new instance.CammyVictoryClass();
			instance.CammyTimeout = new instance.CammyTimeoutClass();
			
			instance.AddFrameScripts();
		}
		
		public var CammyIdle : MovieClip;
		public var CammyBlock : MovieClip;
		public var CammyGroundMediumPunch : MovieClip;
		public var CammyAirMediumPunch : MovieClip;
		public var CammyJumpBackward : MovieClip;
		public var CammyJumpForward : MovieClip;
		public var CammyJumpUp : MovieClip;
		public var CammyWalkBackward : MovieClip;
		public var CammyWalkToward : MovieClip;
		public var CammyStunned : MovieClip;
		public var CammyIntro : MovieClip;
		public var CammyVictory : MovieClip;
		public var CammyTimeout : MovieClip;
		
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyIdle')]
		public var CammyIdleClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyBlock')]
		public var CammyBlockClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyGroundMediumPunch')]
		public var CammyGroundMediumPunchClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyAirMediumPunch')]
		public var CammyAirMediumPunchClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpBackward')]
		public var CammyJumpBackwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpForward')]
		public var CammyJumpForwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpUp')]
		public var CammyJumpUpClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkForward')]
		public var CammyWalkTowardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkBackward')]
		public var CammyWalkBackwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyStunned')]
		public var CammyStunnedClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyIntro')]
		public var CammyIntroClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyVictory')]
		public var CammyVictoryClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyTimeout')]
		public var CammyTimeoutClass : Class
		
		public function Animations(se:SingletonEnforcer)
		{
		}
		
		private function AddFrameScripts():void
		{
			AddStopScriptAtLastFrame( CammyBlock );
			AddStopScriptAtLastFrame( CammyGroundMediumPunch );
			AddStopScriptAtLastFrame( CammyAirMediumPunch );
			AddStopScriptAtLastFrame( CammyJumpBackward );
			AddStopScriptAtLastFrame( CammyJumpForward );
			AddStopScriptAtLastFrame( CammyJumpUp );
			AddStopScriptAtLastFrame( CammyStunned );
			AddStopScriptAtLastFrame( CammyIntro );
			AddStopScriptAtLastFrame( CammyVictory );
			AddStopScriptAtLastFrame( CammyTimeout );
		}
		
		private function AddStopScriptAtLastFrame(mc:MovieClip):void
		{
			mc.addFrameScript(mc.totalFrames, function():void
			{
				mc.stop();
			});
		}
		
	}
}

internal class SingletonEnforcer { }
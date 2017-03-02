package fighter.view
{
	import flash.display.MovieClip;

	public class CammyAnimations implements Animations
	{
		public function get Idle() : MovieClip
		{
			return idle;
		}
		public function get Block() : MovieClip
		{
			return block;
		}
		public function get GroundMediumPunch() : MovieClip
		{
			return groundMediumPunch;
		}
		public function get AirMediumPunch() : MovieClip
		{
			return airMediumPunch;
		}
		public function get JumpBackward() : MovieClip
		{
			return jumpBackward;
		}
		public function get JumpForward() : MovieClip
		{
			return jumpForward;
		}
		public function get JumpUp() : MovieClip
		{
			return jumpUp;
		}
		public function get WalkBackward() : MovieClip
		{
			return walkBackward;
		}
		public function get WalkForward() : MovieClip
		{
			return walkForward;
		}
		public function get Stunned() : MovieClip
		{
			return stunned;
		}
		public function get Intro() : MovieClip
		{
			return intro;
		}
		public function get Victory() : MovieClip
		{
			return victory;
		}
		public function get Timeout() : MovieClip
		{
			return timeout;
		}
		
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyIdle')]
		private var IdleClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyBlock')]
		private var BlockClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyGroundMediumPunch')]
		private var GroundMediumPunchClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyAirMediumPunch')]
		private var AirMediumPunchClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpBackward')]
		private var JumpBackwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpForward')]
		private var JumpForwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyJumpUp')]
		private var JumpUpClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkForward')]
		private var WalkForwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyWalkBackward')]
		private var WalkBackwardClass : Class;
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyStunned')]
		private var StunnedClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyIntro')]
		private var IntroClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyVictory')]
		private var VictoryClass : Class
		[Embed(source='../../../assets/img/animations/CammyAnimations.swf', symbol='CammyTimeout')]
		private var TimeoutClass : Class
		
		public function CammyAnimations()
		{
			block = new BlockClass();
			idle = new IdleClass();
			groundMediumPunch = new GroundMediumPunchClass();
			airMediumPunch = new AirMediumPunchClass();
			jumpBackward = new JumpBackwardClass();
			jumpForward = new JumpForwardClass();
			jumpUp = new JumpUpClass();
			walkBackward = new WalkBackwardClass();
			walkForward = new WalkForwardClass();
			stunned = new StunnedClass();
			intro = new IntroClass();
			victory = new VictoryClass();
			timeout = new TimeoutClass();
			
			AddFrameScripts();
		}
		
		private function AddFrameScripts():void
		{
			AddStopScriptAtLastFrame( Block );
			AddStopScriptAtLastFrame( GroundMediumPunch );
			AddStopScriptAtLastFrame( AirMediumPunch );
			AddStopScriptAtLastFrame( JumpBackward );
			AddStopScriptAtLastFrame( JumpForward );
			AddStopScriptAtLastFrame( JumpUp );
			AddStopScriptAtLastFrame( Stunned );
			AddStopScriptAtLastFrame( Intro );
			AddStopScriptAtLastFrame( Victory );
			AddStopScriptAtLastFrame( Timeout );
		}
		
		private function AddStopScriptAtLastFrame(mc:MovieClip):void
		{
			mc.addFrameScript(mc.totalFrames-1, function():void
			{
				mc.stop();
			});
		}
		
		private var idle : MovieClip
		private var block : MovieClip;
		private var groundMediumPunch : MovieClip;
		private var airMediumPunch : MovieClip;
		private var jumpBackward : MovieClip;
		private var jumpForward : MovieClip;
		private var jumpUp : MovieClip;
		private var walkBackward : MovieClip;
		private var walkForward : MovieClip;
		private var stunned : MovieClip;
		private var intro : MovieClip;
		private var victory : MovieClip;
		private var timeout : MovieClip;
		
	}
}

internal class SingletonEnforcer { }
package fighter.view
{
	import flash.display.MovieClip;

	public interface Animations
	{
		function get Idle() : MovieClip;
		function get Block() : MovieClip;
		function get GroundMediumPunch() : MovieClip;
		function get AirMediumPunch() : MovieClip;
		function get JumpBackward() : MovieClip;
		function get JumpForward() : MovieClip;
		function get JumpUp() : MovieClip;
		function get WalkBackward() : MovieClip;
		function get WalkForward() : MovieClip;
		function get Stunned() : MovieClip;
		function get Intro() : MovieClip;
		function get Victory() : MovieClip;
		function get Timeout() : MovieClip;
	}
}
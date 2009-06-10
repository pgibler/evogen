package game.model.match 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Level 
	{
		
		public function get GroundY():Number
		{
			return 100;
		}
		
		public function get LeftWallX():Number
		{
			return -200;
		}
		
		public function get RightWallX():Number
		{
			return 200;
		}
		
		public function get Background():DisplayObject
		{
			return background;
		}
		
		public function get Ground():DisplayObject
		{
			return ground;
		}
		
		public function Level(background:DisplayObject, ground:DisplayObject) 
		{
			this.background = background;
			this.ground = ground;
		}
		
		private var background : DisplayObject;
		private var ground : DisplayObject;
		
	}
	
}
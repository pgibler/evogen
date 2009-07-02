package fighter.model.game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class DefaultLevel extends Level
	{
		[Embed(source="../../../../assets/img/levels/ocean.jpg")]
		private var imgCls:Class;
		
		private var background:Sprite;
		private var ground:Sprite;
		
		public function DefaultLevel()
		{
			var lvlWidth : Number = Math.abs(LeftWallX)+Math.abs(RightWallX);
			background = new Sprite();
			ground = new Sprite();
			super(background, ground);
			var sizeRatio : Number = lvlWidth / background.width;
			ground.graphics.beginFill(0xFFFFFF*Math.random());
			ground.graphics.drawRect(LeftWallX,GroundY,lvlWidth,150);
			ground.graphics.endFill();
			
			background.graphics.beginFill(0xFFFFFF*Math.random());
			background.graphics.drawRect(LeftWallX, -400, lvlWidth, 500);
			background.graphics.endFill();
		}
	}
}
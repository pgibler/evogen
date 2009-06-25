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
			ground.graphics.beginFill(0xFFFFFF*Math.random(),.1);
			ground.graphics.drawRect(LeftWallX,GroundY,lvlWidth,100);
			ground.graphics.endFill();
			
			background.graphics.beginFill(0xFFFFFF*Math.random());
			background.graphics.drawRect(LeftWallX, 0, lvlWidth, 200);
			background.graphics.endFill();
		}
	}
}
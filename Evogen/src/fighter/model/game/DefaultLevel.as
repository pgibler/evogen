package fighter.model.game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class DefaultLevel extends Level
	{
		[Embed(source="../../../../assets/img/levels/ocean.jpg")]
		private var imgCls:Class;
		
		public function DefaultLevel()
		{
			var lvlWidth : Number = Math.abs(LeftWallX)+Math.abs(RightWallX);
			var background:Bitmap = new imgCls();
			var sizeRatio : Number = lvlWidth / background.width;
			background.width = lvlWidth;
			background.height *= sizeRatio;
			var ground:Sprite = new Sprite();
			ground.graphics.beginFill(0xFFFFFF*Math.random(),.1);
			ground.graphics.drawRect(LeftWallX,GroundY,lvlWidth,100);
			ground.graphics.endFill();
			super(background, ground);
			background.x = 0;
			background.y = 0;
		}
	}
}
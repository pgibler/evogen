package fighter.model.game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class DefaultLevel extends Level
	{
		[Embed(source="../../../../assets/img/levels/battleground.jpg")]
		private var backgroundImageCls:Class;
		
		[Embed(source="../../../../assets/img/levels/Beige_Sand_Tiles.jpg")]
		private var groundImageClass:Class;
		
		private var background:Sprite;
		private var ground:Sprite;
		
		public function DefaultLevel()
		{
			var lvlWidth : Number = Math.abs(LeftWallX)+Math.abs(RightWallX);
			background = new Sprite();
			ground = new Sprite();
			super(background, ground);
			var sizeRatio : Number = lvlWidth / background.width;
			var groundImage : Bitmap = new groundImageClass();
			ground.graphics.beginBitmapFill(groundImage.bitmapData);
			ground.graphics.drawRect(LeftWallX,GroundY,lvlWidth,150);
			ground.graphics.endFill();
			
			background.graphics.beginBitmapFill(new backgroundImageCls().bitmapData);
			background.graphics.drawRect(LeftWallX, -400, lvlWidth, 500);
			background.graphics.endFill();
		}
	}
}
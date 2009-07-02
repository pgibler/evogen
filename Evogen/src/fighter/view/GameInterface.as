package fighter.view
{
	import fighter.model.game.Game;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class GameInterface extends Sprite
	{
		
		public function get Player1HealthBar():DisplayObject
		{
			return player1HealthBar;
		}
		
		public function get Player2HealthBar():DisplayObject
		{
			return player2HealthBar;
		}
		
		public function GameInterface()
		{
			super();
			var healthBarYOffset : Number = -200;
			var healthBarXOffset : Number = 200;
			player1HealthBar = AddDisplayObject(CreateHealthBar("Player1Health"), healthBarXOffset, healthBarYOffset);
			player2HealthBar = AddDisplayObject(CreateHealthBar("Player2Health"), -healthBarXOffset, healthBarYOffset)
		}
		
		public function Update(game:Game):void
		{
			player1HealthBar.scaleX = game.Player1.Health / game.Player1.HealthMax;
			player2HealthBar.scaleX = game.Player2.Health / game.Player2.HealthMax;
		}
		
		private function AddDisplayObject(dispObj:DisplayObject, x:Number, y:Number):DisplayObject
		{
			addChild(dispObj);
			dispObj.x = x;
			dispObj.y = y;
			return dispObj;
		}
		
		private function CreateHealthBar(name:String):Sprite
		{
			var returnme : Sprite = new Sprite();
			returnme.name = name;
			returnme.graphics.beginFill(0xFF0000);
			returnme.graphics.drawRect(0,0,200,30);
			returnme.graphics.endFill();
			return returnme;
		}
		
		private var player1HealthBar : DisplayObject;
		private var player2HealthBar : DisplayObject;
		private var listeningToGame : Game;
	}
}
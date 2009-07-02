package fighter.model.game
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class GameSettings
	{
		
		public function get GameRunTime():int
		{
			return gameRunTime;
		}
		
		public function get FrameIntervalsPerTick():int
		{
			return frameIntervalsPerTick
		}
		
		public function get SimulationIntervalsPerTick():int
		{
			return simulationIntervalsPerTick;
		}
		
		public function set Mode(newMode:int):void
		{
			this.mode = newMode;
			frameIntervalsPerTick = this.mode == Game.SIMULATION ? simulationIntervalsPerTick : 1;
		}
		
		public function get Mode():int
		{
			return mode;
		}
		
		public function get DisplayContainer():DisplayObjectContainer
		{
			return displayContainer;
		}
		
		public function get GameContainer():DisplayObjectContainer
		{
			return gameContainer;
		}
		
		public function get GameInterfaceContainer():DisplayObjectContainer
		{
			return gameInterfaceContainer;
		}
		
		public function get GamePlayContainer():DisplayObjectContainer
		{
			return gamePlayContainer;
		}
		
		public function GameSettings(displayContainer:DisplayObjectContainer, mode:int = 0, gameRunTime:int=3600)
		{
			gameContainer = new Sprite();
			gamePlayContainer = new Sprite();
			gamePlayContainer.name = "Play";
			gameContainer.addChild(gamePlayContainer);
			gameInterfaceContainer = new Sprite();
			gameInterfaceContainer.name = "Interface";
			gameContainer.addChild(gameInterfaceContainer);
			this.displayContainer = displayContainer;
			this.gameRunTime = gameRunTime;
			this.simulationIntervalsPerTick = 500;
			this.frameIntervalsPerTick = mode == 0 ? simulationIntervalsPerTick : 1;
			this.mode = mode;
			
			displayContainer.addChild(gameContainer);
		}
		
		private var gamePlayContainer : DisplayObjectContainer;
		private var gameInterfaceContainer : DisplayObjectContainer;
		private var gameContainer : DisplayObjectContainer;
		private var displayContainer : DisplayObjectContainer;
		private var gameRunTime : int;
		private var mode : int;
		private var simulationIntervalsPerTick : int;
		private var frameIntervalsPerTick : int;
	}
}
package fighter.model.game
{
	import flash.display.DisplayObjectContainer;

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
		
		public function get Mode():int
		{
			return mode;
		}
		
		public function get DisplayContainer():DisplayObjectContainer
		{
			return container;
		}
		
		public function GameSettings(container:DisplayObjectContainer, mode:int = 0, gameRunTime:int=3600)
		{
			this.container = container;
			this.gameRunTime = gameRunTime;
			this.frameIntervalsPerTick = 1;
			this.mode = mode;
		}
		
		private var container : DisplayObjectContainer;
		private var gameRunTime : int;
		private var mode : int;
		private var frameIntervalsPerTick : int;
	}
}
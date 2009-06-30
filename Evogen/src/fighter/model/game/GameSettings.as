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
			return container;
		}
		
		public function GameSettings(container:DisplayObjectContainer, mode:int = 0, gameRunTime:int=3600)
		{
			this.container = container;
			this.gameRunTime = gameRunTime;
			this.simulationIntervalsPerTick = 500;
			this.frameIntervalsPerTick = mode == 0 ? simulationIntervalsPerTick : 1;
			this.mode = mode;
		}
		
		private var container : DisplayObjectContainer;
		private var gameRunTime : int;
		private var mode : int;
		private var simulationIntervalsPerTick : int;
		private var frameIntervalsPerTick : int;
	}
}
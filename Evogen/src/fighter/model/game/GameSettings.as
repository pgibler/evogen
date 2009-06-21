package fighter.model.game
{
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
		
		public function GameSettings(gameRunTime:int=3600, frameIntervalsPerTick:int = 100, mode:int = 0)
		{
			this.gameRunTime = gameRunTime;
			this.frameIntervalsPerTick = frameIntervalsPerTick;
			this.mode = mode;
		}
		
		private var gameRunTime : int;
		private var mode : int;
		private var frameIntervalsPerTick : int;
	}
}
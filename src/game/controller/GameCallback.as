package game.controller
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface GameCallback 
	{
		function OnFrameStart(gs:GameState):void;
		function OnFrameEnd(gs:GameState):void;
		function OnGameStart(gs:GameState):void;
		function OnGameEnd(gs:GameState):void;
	}
	
}
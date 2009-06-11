package fighter.controller.callback
{
	import fighter.model.game.Game;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface GameCallback 
	{
		function OnFrameStart(game:Game):void;
		function OnFrameUpdate(game:Game):void;
		function OnFrameEnd(game:Game):void;
		function OnGameStart(game:Game):void;
		function OnGameEnd(game:Game):void;
	}
	
}
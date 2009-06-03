package game.controller.callback
{
	import game.model.game.Game;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface GameCallback 
	{
		function OnFrameStart(game:Game):void;
		function OnFrameUpdate(game:Game):void;
		function OnFrameEnd(game:Game):void;
		function OnRoundStart(game:Game):void;
		function OnRoundEnd(game:Game):void;
		function OnMatchStart(game:Game):void;
		function OnMatchEnd(game:Game):void;
	}
	
}
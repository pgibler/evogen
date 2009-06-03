package game.controller.callback
{
	import game.model.game.Game;
	import game.model.match.Match;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface MatchCallback 
	{
		function OnFrameStart(match:Match):void;
		function OnFrameUpdate(match:Match):void;
		function OnFrameEnd(match:Match):void;
		function OnRoundStart(match:Match):void;
		function OnRoundEnd(match:Match):void;
		function OnMatchStart(match:Match):void;
		function OnMatchEnd(match:Match):void;
	}
	
}
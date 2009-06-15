package fighter.controller.callback
{
	import fighter.model.game.GameEvent;
	import fighter.model.tournament.Tournament;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface TournamentCallback 
	{
		function OnTournamentStart(tournament:Tournament):void;
		function OnTournamentEnd(tournament:Tournament):void;
		function OnTournamentGameStart(event:GameEvent):void;
		function OnTournamentGameEnd(event:GameEvent):void;
	}
	
}
package game.controller.callback
{
	import game.model.tournament.Tournament;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface TournamentCallback 
	{
		function OnTournamentStart(tournament:Tournament):void;
		function OnTournamentEnd(tournament:Tournament):void;
		function OnTournamentRoundStart(tournament:Tournament):void;
		function OnTournamentRoundEnd(tournament:Tournament):void;
	}
	
}
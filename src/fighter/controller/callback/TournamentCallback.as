package fighter.controller.callback
{
	import fighter.model.game.Game;
	import fighter.model.tournament.Tournament;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public interface TournamentCallback 
	{
		function OnTournamentStart(tournament:Tournament):void;
		function OnTournamentEnd(tournament:Tournament):void;
		function OnTournamentUpdate(tournament:Tournament, game:Game):void;
		function OnTournamentGameEnd(tournament:Tournament, game:Game):void;
	}
	
}
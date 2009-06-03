package game.model.tournament 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class TournamentSettings 
	{
		
		public function get RoundWinsToWinMatch():int
		{
			return roundWinsToWinMatch;
		}
		
		public function TournamentSettings() 
		{
			
		}
		
		private var roundWinsToWinMatch : int;
		private var numberOfRounds : int;
		
	}
	
}
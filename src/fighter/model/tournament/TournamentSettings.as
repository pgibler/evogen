package fighter.model.tournament 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class TournamentSettings 
	{
		
		public function get RoundWinsToWinGame():int
		{
			return roundWinsToWinGame;
		}
		
		public function TournamentSettings() 
		{
			
		}
		
		private var roundWinsToWinGame : int;
		private var numberOfRounds : int;
		
	}
	
}
package fighter.model.tournament 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class TournamentSettings 
	{
		
		public function get GameWinsToWinMatch():int
		{
			return gameWinsToWinMatch;
		}
		
		public function TournamentSettings(gameWinsToWinMatch:int=1) 
		{
			this.gameWinsToWinMatch = gameWinsToWinMatch;
		}
		
		private var gameWinsToWinMatch : int;
		
	}
	
}
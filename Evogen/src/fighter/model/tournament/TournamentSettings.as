package fighter.model.tournament 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class TournamentSettings 
	{
		
		public function get PopulationSize():int
		{
			return populationSize;
		}
		
		public function get GameWinsToWinMatch():int
		{
			return gameWinsToWinMatch;
		}
		
		public function TournamentSettings(populationSize:int, gameWinsToWinMatch:int=1) 
		{
			this.populationSize = populationSize;
			this.gameWinsToWinMatch = gameWinsToWinMatch;
		}
		
		private var populationSize : int;
		private var gameWinsToWinMatch : int;
		
	}
	
}
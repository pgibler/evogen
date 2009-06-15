package fighter.model.tournament 
{
	import fighter.model.character.Character;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class TournamentResults 
	{
		
		public function AddCharacter(c:Character):void
		{
			characters.push(c);
			characterWins.push(0);
			characterLosses.push(0);
		}
		
		public function AddGameResult(winner:Character, loser:Character):void
		{
			var winnerIndex : int = characters.indexOf(winner);
			var loserIndex : int = characters.indexOf(loser);
			characterWins[winnerIndex] = characterWins[winnerIndex] + 1;
			characterLosses[loserIndex] = characterLosses[loserIndex] + 1;
		}
		
		public function FinalizeTournament():void
		{
			for (var i : int = 0; i < characters.length; i++)
			{
				var c : Character = characters[i];
				c.CharacterSpecimen.Data["wins"] = c.CharacterSpecimen.Data["wins"] + characterWins[i];
				c.CharacterSpecimen.Data["losses"] = c.CharacterSpecimen.Data["losses"] + characterLosses[i];
			}
		}
		
		public function TournamentResults() 
		{
			
		}
		
		private var characters : Vector.<Character>;
		private var characterWins : Vector.<int>;
		private var characterLosses : Vector.<int>;
		
	}
	
}
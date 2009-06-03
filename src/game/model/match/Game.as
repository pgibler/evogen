package game.model.match
{
	import game.model.character.Character;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Game 
	{
		
		public var IsComplete:Boolean;
		public function get Player1():Character
		{
			return player1;
		}
		public function get Player2():Character
		{
			return player2;
		}
		
		public function Game(player1:Character, player2:Character) 
		{
			this.player1 = p1;
			this.player2 = p2;
			this.IsComplete = false;
		}
		
		private var player1 : Character;
		private var player2 : Character;
		
	}
	
}
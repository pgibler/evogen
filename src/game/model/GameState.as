package game.model
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class GameState 
	{
		
		public function get Player1():Character
		{
			return player1;
		}
		public function get Player2():Character
		{
			return player2;
		}
		
		public function GameState(player1:Character, player2:Character) 
		{
			this.player1 = p1;
			this.player2 = p2;
		}
		
		private var player1 : Character;
		private var player2 : Character;
		
	}
	
}
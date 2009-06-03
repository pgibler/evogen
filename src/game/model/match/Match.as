package game.model.match
{
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Match 
	{
		
		public function get IsComplete():Boolean
		{
			return matchOver;
		}
		public function get CurrentRound():int
		{
			return currentRound;
		}
		public function get Player1():Player
		{
			return player1;
		}
		public function get Player2():Player
		{
			return player2;
		}
		public function get Player1Wins():int
		{
			return player1Wins;
		}
		public function get Player2Wins():int
		{
			return player2Wins;
		}
		
		public function get Winner():Player
		{
			return winner;
		}
		
		public function Match(player1:Player, player2:Player) 
		{
			this.player1 = p1;
			this.player2 = p2;
			this.IsComplete = false;
			this.CurrentRound = 0;
			this.player1Wins = 0;
			this.player2Wins = 0;
		}
		
		public function GoToNextRound(roundWinner:Player):void
		{
			currentRound++;
		}
		
		public function DeclareWinner(player:Player):void
		{
			if (player == player1 || player == player2)
			{
				this.winner = player;
			}
			else
			{
				throw new Error("Winner must be a participant in this match.");
			}
		}
		
		private var player1Wins : int;
		private var player2Wins : int;
		private var currentRound : int;
		private var matchOver : Boolean;
		private var winner : Player;
		private var player1 : Player;
		private var player2 : Player;
		
	}
	
}
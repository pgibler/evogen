package fighter.model.tournament
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Tournament
	{
		
		public function get NextPlayer():Player
		{
			currentPlayer++;
			return currentPlayer < players.length-1 ? players[currentPlayer] : null;
		}
		
		public function get IsComplete():Boolean
		{
			return gamesCompleted == gamesRequiredToComplete; 
		}
		
		public function get TopPlayer():Player
		{
			return topPlayer;
		}
		
		public function set TopPlayer(player:Player):void
		{
			this.topPlayer = topPlayer;
		}
		
		public function set CurrentGame(game:Game):void
		{
			this.currentGame = game;
		}
		
		public function get CurrentGame():Game
		{
			return currentGame;
		}
		
		public function get Settings():TournamentSettings
		{
			return tournamentSettings;
		}
		
		public function get Players():Vector.<Player>
		{
			return players;
		}
		
		public function get Games():Vector.<Game>
		{
			return games;
		}
		
		public function get TournamentPlayers():Vector.<Player>
		{
			return players;
		}
		
		public function get GameWinsToWinMatch():int
		{
			return gameWinsToWinMatch;
		}
		
		public function Tournament(tournamentCallback:TournamentCallback, players:Vector.<Player>, topPlayer:Player, gameWinsToWinMatch:int=1) 
		{
			this.tournamentCallback = tournamentCallback;
			this.tournamentSettings = tournamentSettings;
			this.players = players;
			this.topPlayer = topPlayer;
			this.gameWinsToWinMatch = gameWinsToWinMatch;
			this.gamesCompleted = 0;
			this.gamesRequiredToComplete = players.length-1;
			this.games = new Vector.<Game>();
			this.currentPlayer = 1;
		}
		
		private var currentPlayer : int;
		private var gameWinsToWinMatch : int;
		private var topPlayer : Player;
		private var gamesCompleted : int;
		private var gamesRequiredToComplete : int;
		private var currentGame : Game;
		private var games : Vector.<Game>;
		private var players : Vector.<Player>;
		private var tournamentCallback : TournamentCallback;
		private var tournamentSettings : TournamentSettings;
		
	}
	
}
package fighter.model.tournament
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Tournament
	{
		
		public function get TournamentGameSettings():GameSettings
		{
			return gameSettings;
		}
		
		public function get NextPlayer():Player
		{
			currentPlayer++;
			return currentPlayer < players.length ? players[currentPlayer] : null;
		}
		
		public function get IsComplete():Boolean
		{
			return currentPlayer >= players.length; 
		}
		
		public function get TopPlayer():Player
		{
			return topPlayer;
		}
		
		public function set TopPlayer(player:Player):void
		{
			this.topPlayer = player;
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
			return settings;
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
		
		public function Tournament(tournamentCallback:TournamentCallback, players:Vector.<Player>, topPlayer:Player, settings:TournamentSettings, gameSettings:GameSettings) 
		{
			this.tournamentCallback = tournamentCallback;
			this.players = players;
			this.topPlayer = topPlayer;
			this.settings = settings;
			this.games = new Vector.<Game>();
			this.currentPlayer = 0;
			this.gameSettings = gameSettings;
		}
		
		private var currentPlayer : int;
		private var settings : TournamentSettings;
		private var gameSettings : GameSettings;
		private var topPlayer : Player;
		private var currentGame : Game;
		private var games : Vector.<Game>;
		private var players : Vector.<Player>;
		private var tournamentCallback : TournamentCallback;
		
	}
	
}
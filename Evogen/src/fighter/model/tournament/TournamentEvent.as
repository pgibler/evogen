package fighter.model.tournament 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class TournamentEvent extends Event 
	{
		
		public static const TOURNAMENT_OVER : String = "TOURNAMENT_OVER";
		public static const TOURNAMENT_START : String = "TOURNAMENT_START";
		
		public function GetTournament():Tournament
		{
			return tournament;
		}
		
		private var tournament : Tournament;
		
		public function TournamentEvent(tournament:Tournament, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.tournament = tournament;
			
		} 
		
		public override function clone():Event 
		{ 
			return new TournamentEvent(tournament, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TournamentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
package game.controller.callback 
{
	import flash.geom.Point;
	import game.model.match.Match;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class MatchCallbackImpl implements MatchCallback
	{
		
		/* INTERFACE game.controller.callback.MatchCallback */
		
		public function OnFrameStart(match:Match):void
		{
			
		}
		
		public function OnFrameUpdate(match:Match):void
		{
			var p1 : Player = match.Player1;
			var p2 : Player = match.Player2;
			p1.Controller.Update(match);
			p2.Controller.Update(match);
			match.TimeElapsed += 1;
		}
		
		public function OnFrameEnd(match:Match):void
		{
			
		}
		
		public function OnRoundStart(match:Match):void
		{
			match.Player1.Initialize();
			match.Player2.Initialize();
			
			var startPos1 : Point = match.StartingPositions[0];
			var startPos2 : Point = match.StartingPositions[1];
			
			if (Math.random() >= .5)
			{
				match.Player1.Position = startPos1;
				match.Player2.Position = startPos2;
			}
			else
			{
				match.Player1.Position = startPos2;
				match.Player2.Position = startPos1;
			}
		}
		
		public function OnRoundEnd(match:Match):void
		{
			var winner : Player = match.Winner;
			var loser : Player = match.Loser;
		}
		
		public function OnMatchStart(match:Match):void
		{
			
		}
		
		public function OnMatchEnd(match:Match):void
		{
			
		}
		
	}
	
}
package game.controller.character 
{
	import flash.errors.IllegalOperationError;
	import game.model.character.Character;
	import game.model.state.GameState;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class CharacterController 
	{
		
		public function CharacterController(character:Character) 
		{
			this.character = character;
		}
		
		public function Update(gs:GameState):Character
		{
			return this;
		}
		
		private var character : Character;
		
	}
	
}
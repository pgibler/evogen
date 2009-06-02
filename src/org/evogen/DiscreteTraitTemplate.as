package org.evogen 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class DiscreteTraitTemplate implements TraitTemplate
	{
		
		public function DiscreteTraitTemplate(name:String) 
		{
			this.states = new Vector.<String>();
			this.name = name;
		}
		
		/**
		 * Adds a state to the trait template.
		 * @param	state The state to be added.
		 * @return	A reference to this trait template for convenience.
		 */
		public function AddState(state:String):DiscreteTraitTemplate
		{
			_states.push(state);
			return this;
		}
		
		/**
		 * Removes a state from the trait template.
		 * @param	state The state to add to the trait template.
		 * @return	A reference to this trait template for convenience.
		 */
		public function RemoveState(state:String):DiscreteTraitTemplate
		{
			_states.splice(_states.indexOf(state), 1);
			return this;
		}
		
		/* INTERFACE org.evogen.TraitTemplate */
		
		public function FromDNA(dna:String):Trait
		{
			var trait : DiscreteTrait = new DiscreteTrait(name, this);
			for each(var s : String in states)
			{
				trait.addState(s);
			}
			var dnaChar : String = dna.substr(0, dnaLength);
			trait.currentState = states[parseInt(dnaChar)];
			return trait;
		}
		
		public function GenerateTrait():Trait
		{
			var trait : DiscreteTrait = new DiscreteTrait(name, this);
			for each(var s : String in states)
			{
				trait.addState(s);
			}
			var stateNum : int = Math.round(Math.random() * (states.length - 1));
			trait.currentState = states[stateNum];
			return trait;
		}
		
		public function get DNALength():int
		{
			var digitCount : int = 0;
			var num : int = states.length;
			while (num > 0)
			{
				digitCount++;
				num /= 10;
			}
			return digitCount;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		private var states : Vector.<String>;
		private var name : String;
		
	}
	
}
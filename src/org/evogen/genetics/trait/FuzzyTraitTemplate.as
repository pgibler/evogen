package org.evogen.genetics.trait 
{
	
	/**
	 * <code>FuzzyTraitTemplate</code> defines a trait that has several states whose probabilities of occuring add up to 1, using
	 * concepts from the mathematical field of fuzzy logic. This kind of trait template can be useful for defining things relating
	 * to logic, as you can model what a character does in certain situations by modelling them in a probabilistic manner. As an
	 * example, if a character is crouching, that can be defined as a trait in the system, and the actions the character can perform
	 * while crouching can have various probabilities that are the states in the fuzzy trait.
	 * @author Paul Gibler
	 */
	public class FuzzyTraitTemplate implements TraitTemplate
	{		
		/**
		 * Creates a new instance of FuzzyTraitTemplate.
		 * @param	name The name of the fuzzy trait template.
		 */
		public function FuzzyTraitTemplate(name:String) 
		{
			this.states = new Vector.<String>();
			this.name = name;
		}
		
		/**
		 * Adds a state to the trait template.
		 * @param	state The state to be added.
		 * @return	A reference to this trait template for convenience.
		 */
		public function AddState(state:String):FuzzyTraitTemplate
		{
			states.push(state);
			return this;
		}
		
		/**
		 * Removes a state from the trait template.
		 * @param	state The state to add to the trait template.
		 * @return	A reference to this trait template for convenience.
		 */
		public function RemoveState(state:String):FuzzyTraitTemplate
		{
			states.splice(states.indexOf(state), 1);
			return this;
		}
		
		public function FromDNA(dna:String):Trait
		{
			var thisDNALength : int = states.length * FUZZY_STRING_LENGTH;
			var thisDNA : String = dna.substring(0, thisDNALength);
			dna = dna.substring(thisDNALength, dna.length);
			var trait : FuzzyTrait = new FuzzyTrait(name, this);
			for(var i : int = 0; i < states.length; i++)
			{
				var state : String = states[i];
				var frontDigit : String = thisDNA.substr(FUZZY_STRING_LENGTH * i, 1);
				var backDigits : String = thisDNA.substr(FUZZY_STRING_LENGTH * i + 1, FUZZY_STRING_LENGTH-1);
				var numString : String =  frontDigit + "." + backDigits;
				var prob : Number = parseFloat(numString);
				trait.addState(state, prob);
			}
			return trait;
		}
		
		public function GenerateTrait():Trait
		{
			var t : FuzzyTrait = new FuzzyTrait(name, this);
			if (states.length > 1)
			{
				var vec : Vector.<Number> = new Vector.<Number>();
				var total : Number = 0;
				for (var i : int = 0; i < states.length; i++)
				{
					var value : Number = Math.random();
					total += value;
					vec.push(value);
				}
				for (var j : int = 0; j < vec.length; j++)
				{
					t.stateProbabilities[j] = vec[j] / total;
				}
			}
			else if(states.length == 1)
			{
				t.stateProbabilities[0] = 1;
			}
			else
			{
				throw new Error("FuzzyTraitTemplate " +name + " has no states and cannot generate a trait");
			}
			return t;
		}
				
		public function get DNALength():int
		{
			return FUZZY_STRING_LENGTH * states.length;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = name;
		}
		
		internal static const FUZZY_STRING_LENGTH : int = 4;
		internal var states : Vector.<String>;
		
		private var name : String;
		
	}
	
}
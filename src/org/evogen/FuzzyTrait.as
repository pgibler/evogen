package org.evogen
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	/**
	 * A <code>FuzzyTrait</code> is characteristic that has more than one discrete possible state.
	 * @author Paul Gibler
	 */
	public class FuzzyTrait implements Trait
	{
		/**
		 * The probabilities of each state occuring. The indices of stateProbabilities coincide with the indices of states.
		 */
		public function get StateProbabilities (): Vector.<Number>
		{
			return stateProbabilities;
		}
		/**
		 * The set of all states that the FuzzyTrait can have.
		 */
		public function get States (): Vector.<String>
		{
			return states;
		}
		
		/**
		 * Creates an instance of <code>FuzzyTrait</code>.
		 */
		public function FuzzyTrait(name:String, template:FuzzyTraitTemplate)
		{
			this.name = name;
			_template = template;
			states = new Vector.<String>();
			stateProbabilities = new Vector.<Number>();
		}
				
		internal function AddState(name:String, probability:Number):FuzzyTrait
		{
			states.push(name);
			stateProbabilities.push(probability);
			return this;
		}
		
		public function GetRandomState():String
		{
			var prob : Number = Math.random();
			var currProb : Number = 0;
			var i : int = 0;
			for (; i < stateProbabilities.length-1; i++ )
			{
				currProb += stateProbabilities[i];
				if (currProb >= prob)
				{
					break;
				}
			}
			return states[i];
		}
		
		public function ToDNA():String
		{
			var s : String = "";
			var i : int = 0;
			if (stateProbabilities.length > 1)
			{
				for (; i < stateProbabilities.length; i++)
				{
					var str : String = "0" + stateProbabilities[i].toFixed(FuzzyTraitTemplate.FUZZY_STRING_LENGTH - 1).substr(2, FuzzyTraitTemplate.FUZZY_STRING_LENGTH - 1);
					while (str.length < FuzzyTraitTemplate.FUZZY_STRING_LENGTH)
					{
						str += "0"
					}
					s += str;
				}
			}
			else
			{
				for (s = "1"; i < template.DNALength - 1; i++)
				{
					s += "0";
				}
			}
			return s;
		}
		
		public function mutate():Trait
		{
			var fz : FuzzyTrait = template.generateTrait() as FuzzyTrait;
			this.stateProbabilities = fz.stateProbabilities;
			return this;
		}
		
		public function get Template():TraitTemplate
		{
			return template;
		}

		public function set Name(val:String):void
		{
			name = val;
		}
		public function get Name():String
		{
			return name;
		}

		private var template : FuzzyTraitTemplate;
		private var name : String;
		private var states : Vector.<String>;
		private var stateProbabilities : Vector.<Number>;
		
	}
	
}
package org.evogen.genetics.trait 
{
	
	
	/**
	 * A <code>ProbabilisticTrait</code> is characteristic that has more than one discrete possible state.
	 * @author Paul Gibler
	 */
	public class ProbabilisticTrait implements Trait
	{
		/**
		 * The probabilities of each state occuring. The indices of stateProbabilities coincide with the indices of states.
		 */
		public function get StateProbabilities (): Vector.<Number>
		{
			return stateProbabilities;
		}
		/**
		 * The set of all states that the ProbabilisticTrait can have.
		 */
		public function get States (): Vector.<String>
		{
			return states;
		}
		
		/**
		 * Creates an instance of <code>ProbabilisticTrait</code>.
		 */
		public function ProbabilisticTrait(name:String, template:ProbabilisticTraitTemplate)
		{
			this.name = name;
			this.template = template;
			states = new Vector.<String>();
			stateProbabilities = new Vector.<Number>();
		}
				
		internal function AddState(name:String, probability:Number):ProbabilisticTrait
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
					var str : String = "0" + stateProbabilities[i].toFixed(ProbabilisticTraitTemplate.FUZZY_STRING_LENGTH - 1).substr(2, ProbabilisticTraitTemplate.FUZZY_STRING_LENGTH - 1);
					while (str.length < ProbabilisticTraitTemplate.FUZZY_STRING_LENGTH)
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
		
		public function Mutate():Trait
		{
			var fz : ProbabilisticTrait = template.GenerateTrait() as ProbabilisticTrait;
			this.stateProbabilities = fz.StateProbabilities;
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
		
		public function Copy():Trait
		{
			var t : ProbabilisticTrait = new ProbabilisticTrait(name, template);
			t.states = states.slice();
			t.stateProbabilities = stateProbabilities.slice();
			return t;
		}

		private var template : ProbabilisticTraitTemplate;
		private var name : String;
		private var states : Vector.<String>;
		private var stateProbabilities : Vector.<Number>;
		
	}
	
}
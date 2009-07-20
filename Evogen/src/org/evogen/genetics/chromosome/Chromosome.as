package org.evogen.genetics.chromosome
{
	import org.evogen.genetics.trait.Trait;
	import org.evogen.util.Nameable;
	
	/**
	 * A <code>Chromosome</code> defines the set of traits that a creature can have.
	 * @author Paul Gibler
	 */
	public class Chromosome implements Nameable
	{
		
		public function get Traits():Vector.<Trait>
		{
			return traits;
		}
		
		public function set Traits(traits:Vector.<Trait>):void
		{
			this.traits = traits;
		}
		
		public function get TraitNames():Vector.<String>
		{
			return traitNames;
		}
		
		public function set TraitNames(traitNames:Vector.<String>):void
		{
			this.traitNames = traitNames;
		}
		
		public function get Template():ChromosomeTemplate
		{
			return template;
		}
		
		/**
		 * Creates an instance of <code>Chromosome</code>.
		 * @param template The template from which the chromosome is generated.
		 */
		public function Chromosome(template:ChromosomeTemplate) 
		{
			this.traits = new Vector.<Trait>();
			this.traitNames = new Vector.<String>();
			this.template = template;
		}
		
		/**
		 * Mutates the Chromosome.
		 * @param	mutationProbability The probability that a trait will mutate. Must be a value between 0 and 1. A value of 0 means that no trait will ever mutates, and a value of 1 means that a trait will always mutate.
		 * @return	A reference to this chromosome.
		 */
		public function Mutate(mutationProbability:Number):Chromosome
		{
			if(mutationProbability < 0 || mutationProbability >= 1)
			{
				throw new Error("Mutation probability must be greater than or equal to 0 and less than 1.")
			}
			for each(var t:Trait in traits)
			{
				var chanceToMutate : Number = Math.random();
				if (chanceToMutate <= mutationProbability)
				{
					t.Mutate();
				}
			}
			return this;
		}
		
		public function SetTrait(traitStr:String, trait:Trait):Chromosome
		{
			trait.Name = traitStr;
			var traitPos : int = traitNames.indexOf(traitStr);
			if (traitPos != -1)
			{
				traits[ traitPos ] = trait;
			}
			else
			{
				traits.push(trait);
				traitNames.push(traitStr);
			}
			return this;
		}
		
		public function GetTrait(traitStr:String):Trait
		{
			return traits[ traitNames.indexOf(traitStr) ];
		}
		
		public function Equals(c:Chromosome):Boolean
		{
			return c.ToDNA() == this.ToDNA();
		}
		
		public function Copy():Chromosome
		{
			var c : Chromosome = new Chromosome(this.template);
			for each(var t : Trait in traits)
			{
				c.traits.push(t.Copy());
			}
			return c;
		}
		
		public function ToDNA():String
		{
			var stringRep : String = "";
			for each(var t:Trait in traits)
			{
				stringRep += t.ToDNA();
			}
			return stringRep;
		}
		
		public function toString():String
		{
			return ToDNA();
		}
		
		/* INTERFACE org.ei.Nameable */
		
		public function get Name():String
		{
			return template.Name;
		}
		
		public function set Name(val:String):void
		{
			template.Name = val;
		}
		
		internal var traitNames : Vector.<String>;
		internal var traits : Vector.<Trait>;
		internal var template : ChromosomeTemplate;
		
	}
	
}
package org.evogen.genetics.chromosome
{
	import org.evogen.genetics.trait.Trait;
	import org.evogen.genetics.trait.TraitTemplate;
	import org.evogen.util.Nameable;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class ChromosomeTemplate implements Nameable
	{
		public function get Traits():Vector.<TraitTemplate>
		{
			return traits;
		}
		
		public function ChromosomeTemplate(name:String="") 
		{
			this.name = name;
			this.traits = new Vector.<TraitTemplate>();
		}
		
		/**
		 * Adds a trait template to the chromosome template.
		 * @param	tt The trait template to add.
		 */
		public function AddTraitTemplate(tt:TraitTemplate):ChromosomeTemplate
		{
			traits.push(tt);
			return this;
		}
		
		/**
		 * Generates a chromosome from DNA that gamees this particular template.
		 * A DNA string is structured as follows:
		 * 	- Traits are a variable series of numbers in a DNA string.
		 *  - Traits are ordered in the DNA. However, due to the varying size of the traits, their starting indice is not guaranteed.
		 * @param	dna The dna which is used to generate the chromosome.
		 * @return	A chromosome from DNA that gamees this particular template.
		 */
		public function FromDNA(dna:String):Chromosome
		{
			var chrom : Chromosome = new Chromosome(this);
			for each(var traitTemplate : TraitTemplate in traits)
			{
				var trait : Trait = traitTemplate.FromDNA(dna);
				dna = dna.substring(traitTemplate.DNALength, dna.length);
				chrom.SetTrait(trait.Name, trait);
			}
			return chrom;
		}
		
		/**
		 * Generate a random chromosome as defined by this template.
		 * @return	A random chromosome as defined by this template.
		 */
		public function GenerateRandomChromosome():Chromosome
		{
			var c : Chromosome = new Chromosome(this);
			for each(var t:TraitTemplate in traits)
			{
				c.SetTrait(t.Name, t.GenerateTrait());
			}
			return c;
		}
		
		/* INTERFACE org.ei.Nameable */
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		internal var name : String;
		internal var traits : Vector.<TraitTemplate>;
		
	}
	
}
package org.evogen.entity
{
	import flash.utils.Dictionary;
	
	import org.evogen.genetics.chromosome.Chromosome;
	
	/**
	 * A <code>Specimen</code> contains traits and a dictionary of data. The data's purpose is to have the information it contains
	 * be utilized by the fitness function during the evaluation of this specimen. This result is used to determine how fit the
	 * specimen and chromosome are.
	 * @author Paul Gibler
	 */
	public class Specimen implements Breedable
	{
		
		public function get SpecimenChromosome() : Chromosome
		{
			return chromosome;
		}
		
		public function get Data() : Dictionary
		{
			return data;
		}
		
		public function get BreedableSpecimen():Specimen
		{
			return this;
		}
		
		/**
		 * Creates an instance of <code>Specimen</code>.
		 * @param	chromosome The <code>Chromosome</code> which contains this specimen's set of traits.
		 */
		public function Specimen(chromosome:Chromosome, data:Dictionary = null) 
		{
			this.chromosome = chromosome;
			this.data = (data == null) ? new Dictionary() : data;
		}
		
		private var chromosome : Chromosome;
		private var data  : Dictionary;
		
	}
	
}
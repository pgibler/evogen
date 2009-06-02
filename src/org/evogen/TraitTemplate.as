package org.evogen
{
	
	/**
	 * <code>TraitTemplate</code> is an interface that defines how a trait is represented in DNA, and can generate traits of its type randomly.
	 * @author Paul Gibler
	 */
	public interface TraitTemplate extends Nameable
	{
		/**
		 * Generates a trait from a DNA string that follows this objects template.
		 * @param	dna The DNA which will be decoded into a trait.
		 * @return	The trait generated from the DNA.
		 */
		function FromDNA(dna:String):Trait;
		/**
		 * Generates a random trait that follows the outline of this trait template.
		 * @return	A random trait that follows the outline of this trait template.
		 */
		function GenerateTrait():Trait;
		/**
		 * Returns the length of the DNA when this trait is converted into a DNA string.
		 */
		function get DNALength():int;
	}
	
}
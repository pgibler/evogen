package org.evogen.genetics.trait 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import org.evogen.util.Nameable;
	
	/**
	 * A <code>Trait</code> is characteristic of a specimen.
	 * @author Paul Gibler
	 */
	public interface Trait extends Nameable
	{
		/**
		 * Generates a string representation of the trait, as DNA.
		 * @return	A string representation of the trait, as DNA.
		 */
		function ToDNA():String;
		/**
		 * Returns the trait template of this trait.
		 */
		function get Template():TraitTemplate;
		/**
		 * Mutates this trait.
		 * @return A reference to this trait.
		 */
		function Mutate():Trait;
		/**
		 * Copies the trait.
		 * @return The copy of the trait.
		 */
		function Copy():Trait;
	}
	
}
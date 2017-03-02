package org.evogen.specimen
{
	/**
	 * Used by the Breeder to extract breedable specimens
	 */
	public interface Breedable
	{
		/**
		 * Gets the breedable specimen from the breedable object.
		 */
		function get BreedableSpecimen():Specimen;
	}
}
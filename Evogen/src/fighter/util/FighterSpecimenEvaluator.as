package fighter.util
{
	import org.evogen.breeder.SpecimenEvaluator;
	import org.evogen.entity.Specimen;
	
	public class FighterSpecimenEvaluator implements SpecimenEvaluator
	{		
		public function EvaluateFitness(specimen:Specimen):Number
		{
			return specimen.BreedableSpecimen.Data["wins"];
		}
	}
}
package fighter.controller.breeder
{
	import org.evogen.breeder.SpecimenEvaluator;
	import org.evogen.entity.Specimen;
	
	public class FighterSpecimenEvaluator implements SpecimenEvaluator
	{		
		public function EvaluateFitness(specimen:Specimen):Number
		{
			return specimen.BreedableSpecimen.Data["Wins"] * 100 + specimen.BreedableSpecimen.Data["AverageLife"] * 1;
		}
		
		public function SortSpecimens(specimens:Vector.<Specimen>):Vector.<Specimen>
		{
			return specimens.slice().sort(function(a:Specimen, b:Specimen):Number
			{
				if(EvaluateFitness(a) > EvaluateFitness(b))
				{
					return -1;
				}
				else if(EvaluateFitness(a) < EvaluateFitness(b))
				{
					return 1;
				}
				return 0;
			});
		}
	}
}
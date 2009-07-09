package fighter.controller.breeder
{
	import flash.utils.Dictionary;
	
	import org.evogen.breeder.SpecimenEvaluator;
	import org.evogen.entity.Specimen;
	
	public class FighterSpecimenEvaluator implements SpecimenEvaluator
	{		
		public function EvaluateFitness(specimen:Specimen):Number
		{
			var d : Dictionary = specimen.BreedableSpecimen.Data;
			return d["Wins"] * 100 + d["AverageDamageDealt"] * 1 + d["AverageSuccessfulBlocks"] * 10;
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
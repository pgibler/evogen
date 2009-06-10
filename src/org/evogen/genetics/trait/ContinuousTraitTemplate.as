package org.evogen.genetics.trait 
{
	
	/**
	 * <code>ContinuousTraitTemplate</code> is a <code>TraitTemplate</code> used for defining continuous traits,
	 * which is the set of traits that can be represented by a range of real numbers from 0 to 1.
	 * @author Paul Gibler
	 */
	public class ContinuousTraitTemplate implements TraitTemplate
	{
		
		public function ContinuousTraitTemplate(name:String) 
		{
			this.name = name;
		}
		
		/* INTERFACE org.ei.TraitTemplate */
		
		public function FromDNA(dna:String):Trait
		{
			var num : String = dna.substring(0, DNALength);
			probability = parseFloat("0." + num);
			return new ContinuousTrait(name, this, probability);
		}
		
		public function GenerateTrait():Trait
		{
			return new ContinuousTrait(name, this, Math.random());
		}
		
		public function get DNALength():int
		{
			return 5;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
		private var probability : Number;
		
	}
	
}
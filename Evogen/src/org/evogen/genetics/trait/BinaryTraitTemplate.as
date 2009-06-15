package org.evogen.genetics.trait 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class BinaryTraitTemplate implements TraitTemplate
	{
		
		public function BinaryTraitTemplate(name:String="") 
		{
			this.name = name;
		}
		
		/* INTERFACE org.evogen.TraitTemplate */
		
		public function get DNALength():int
		{
			return 1;
		}
		
		public function FromDNA(dna:String):Trait
		{
			return new BinaryTrait(name, this, dna == "1");
		}
		
		public function GenerateTrait():Trait
		{
			return new BinaryTrait(name, this, Math.round( Math.random() ) == 1);
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		private var name : String;
		
	}
	
}
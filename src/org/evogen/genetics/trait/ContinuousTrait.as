package org.evogen.genetics.trait 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class ContinuousTrait implements Trait
	{
		
		public function ContinuousTrait(name:String, template:ContinuousTraitTemplate, value:Number) 
		{
			this.name = name;
			this.template = template;
			this.value = value;
		}
		
		public function get Value():Number
		{
			return value;
		}
		
		/* INTERFACE org.ei.Trait */
		
		public function Mutate():Trait
		{
			value = (template.generateTrait() as ContinuousTrait).value;
			return this;
		}
		
		public function ToDNA():String
		{
			var dna : String = String(_value).substr(2, template.DNALength);
			while (dna.length < template.DNALength)
			{
				dna += "0"
			}
			return dna;
		}
		
		public function get Template():TraitTemplate
		{
			return template;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		private var template : ContinuousTraitTemplate;
		private var name : String;
		private var value : Number;

	}
	
}
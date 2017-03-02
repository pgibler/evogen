package org.evogen.genetics.trait 
{
	
	/**
	 * A BinaryTrait is a trait which is either active or not.
	 * @author Paul Gibler
	 */
	public class BinaryTrait implements Trait
	{
		
		public function BinaryTrait(name:String, template:BinaryTraitTemplate, active:Boolean) 
		{
			this.name = name;
			this.template = template;
			this.active = active;
		}
		
		/* INTERFACE org.evogen.Trait */
		
		public function ToDNA():String
		{
			return (active) ? "1" : "0";
		}
		
		public function get Template():TraitTemplate
		{
			return template;
		}
		
		public function Mutate():Trait
		{
			active = !active
			return this;;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		public function set Name(val:String):void
		{
			name = val;
		}
		
		public function Copy():Trait
		{
			return new BinaryTrait(name, template, active);
		}
		
		private var name : String;
		private var template : BinaryTraitTemplate;
		private var active : Boolean;
		
	}
	
}
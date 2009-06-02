﻿package org.evogen 
{
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class DiscreteTrait implements Trait
	{
		
		public function DiscreteTrait(name:String, template:DiscreteTraitTemplate) 
		{
			this.name = name;
			this.template = template;
			this.states = new Vector.<String>();
		}
		
		internal function AddState(state:String):DiscreteTrait
		{
			_states.push(state);
			return this;
		}
		
		public function GetRandomState():String
		{
			return states[Math.round(Math.random() * (states.length-1))];
		}
		
		/* INTERFACE org.evogen.Trait */
		
		public function ToDNA():String
		{
			var dna : String = String(states.indexOf(currentState));
			while (dna.length < template.DNALength)
			{
				dna = "0" + dna;
			}
			return dna;
		}
		
		/* INTERFACE org.evogen.Trait */
		
		public function Nutate():Trait
		{
			var possibleStates : Vector.<String> = states.slice();
			possibleStates.splice(states.indexOf(currentState), 1);
			currentState = possibleStates[ Math.round( Math.random() * (possibleStates.length-1) ) ];
			return this;
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
		
		public function get CurrentState():String {
			return currentState;
		}
		public function set CurrentState(val:String):void {
			currentState = val;
		}
		
		private var currentState : String;
		private var states : Vector.<String>;
		private var template : TraitTemplate;
		private var name : String;
	}
	
}
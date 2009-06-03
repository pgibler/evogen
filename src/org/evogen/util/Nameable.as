package org.evogen.util
{
	
	/**
	 * A <code>Nameable</code> object must have a name.
	 * @author Paul Gibler
	 */
	public interface Nameable 
	{
		function get Name():String;
		function set Name(val:String):void;
	}
	
}
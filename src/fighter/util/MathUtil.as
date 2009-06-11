package fighter.util 
{
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class MathUtil 
	{
		
		public static function ConvertBinaryStringToBaseTenInteger(str:String):int
		{
			var returnval : int = 0;
			for (var i : int = 0; i < str.length; i++)
			{
				returnval += parseInt(str.charAt(i)) * Math.pow(2, i);
			}
			return returnval;
		}
		
		/**
		 * Converts a base ten integer into a binary string.
		 * @param	i The number to convert
		 * @param	stringLengthMin The minimum resulting string length. Preceding zeroes will be added if neccessary.
		 * @return	The string representation of the base 10 b
		 */
		public static function ConvertBaseTenIntegerToBinaryString(i:int, stringLengthMin:int=-1):String
		{
			var returnval : String = "";
			while (i > 0)
			{
				returnval = String(i % 2) + returnval;
				i /= 2;
			}
			while (returnval.length < stringLengthMin)
			{
				returnval = "0" + returnval;
			}
			return returnval;
		}
		
	}
	
}
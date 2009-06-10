package game.util 
{
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class MathUtil 
	{
		
		public static function ConvertBinaryStringToDecimalInteger(str:String):int
		{
			var returnval : int = 0;
			for (var i : int = 0; i < str.length; i++)
			{
				returnval += parseInt(str.charAt(i)) * Math.pow(2, i);
			}
			return returnval;
		}
		
		public static function ConvertDecimalIntegerToBinaryString(i:int):String
		{
			var returnval : String = "";
			while (i > 0)
			{
				returnval += String(i % 2);
				i /= 2;
			}
			return returnval;
		}
		
	}
	
}
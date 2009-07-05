package org.gibler.util
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Graph extends Sprite
	{
		public function get Max():Number
		{
			return max;
		}
		
		public function get Min():Number
		{
			return min;
		}
		
		public function get StandardDeviation():Number
		{
			return GetStandardDeviationInRange();
		}
		
		public function get Variance():Number
		{
			return GetVarianceInRange();
		}
		
		public function GetVarianceInRange(startIndex:Number=0; endIndex:Number=0):void
		{
			var mean : Number = Mean;
			var variance : Number = 0;
			SliceAndSort(startIndex, endIndex).forEach(function(val:Number, index:int, vec:Vector.<Number>):void
			{
				variance += Math.pow(val - mean, 2);
			});
			return variance / values.length-1;
		}
		
		public function GetStandardDeviationInRange(startIndex:Number=0; endIndex:Number=0):void
		{
			return Math.sqrt(GetVarianceInRange(startIndex, endIndex));
		}
		
		public function GetMaxInRange(startIndex:Number=0, endIndex:Number=0):void
		{
			var copy : Vector.<Number> = SliceAndSort(startIndex, endIndex);
			max = copy[0];
		}
		
		public function get Mean():Number
		{
			var total : Number = 0;
			for(var i : int = 0; i < values.length; i++)
			{
				total += values[i];
			}
			return total / values.length;
		}
		
		public function Graph(values:Vector.<Number>, displayWidth:Number=-1, displayHeight:Number=-1, graphWidth:int = 5)
		{
			super();
			this.graphWidth = graphWidth;
			this.displayHeight = displayHeight;
			this.displayWidth = displayWidth;
			this.graphHolder = new Sprite();
		}
		
		public function UpdateValues():void
		{
			var copy : Vector.<Number> = SliceAndSort();
			max = copy[0];
			min = copy[copy.length-1];
		}
		
		public function Update(event:Event = null):void
		{
			UpdateValues();
			
			graphHolder.graphics.clear();
			graphHolder.graphics.lineStyle(1,0xFFFFFF);
			graphHolder.graphics.moveTo(0,max);
			graphHolder.graphics.lineTo(0,min);
			graphHolder.graphics.moveTo(0,0)
			
			graphHolder.width = displayWidth;
			graphHolder.height = displayHeight;
		}
		
		private function SliceAndSort(startIndex:Number=0, endIndex:Number=0):Vector.<Number>
		{
			var copy : Vector.<Number> = Slice().sort(function(val1:Number, val2:Number):Number
			{
				return val2 - val1;
			});
			return copy;
		}
		
		private function Slice(startIndex:Number=0, endIndex:Number=0):Vector.<Number>
		{
			if(endIndex == 0)
			{
				endIndex = values.length;
			}
			if(endIndex <= startIndex)
			{
				throw new Error("End index must be larger than start index");
			}
			var copy : Vector.<Number> = values.slice();
			copy = copy.slice(startIndex, endIndex);
			return copy;
		}
		
		private var graphHolder : Sprite;
		private var graphWidth : int;
		private var displayWidth : Number;
		private var displayHeight : Number;
		private var values : Vector.<Number>;
		private var max : Number;
		private var min : Number;
		private var length : Number;
	}
}
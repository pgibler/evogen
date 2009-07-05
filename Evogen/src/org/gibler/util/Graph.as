package org.gibler.util
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
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
		
		public function get Mean():Number
		{
			return GetMeanInRange();
		}
		
		public function GetVarianceInRange(startIndex:Number=0, endIndex:Number=0):Number
		{
			var mean : Number = Mean;
			var variance : Number = 0;
			Slice(startIndex, endIndex).forEach(function(val:Number, index:int, vec:Vector.<Number>):void
			{
				variance += Math.pow(val - mean, 2);
			});
			return variance / values.length-1;
		}
		
		public function GetStandardDeviationInRange(startIndex:Number=0, endIndex:Number=0):Number
		{
			return Math.sqrt(GetVarianceInRange(startIndex, endIndex));
		}
		
		public function GetMaxInRange(startIndex:Number=0, endIndex:Number=0):Number
		{
			var copy : Vector.<Number> = SliceAndSort(startIndex, endIndex);
			return copy[0];
		}
		
		public function GetMeanInRange(startIndex:Number=0, endIndex:Number=0):Number
		{
			var copy : Vector.<Number> = Slice(startIndex, endIndex);
			var total : Number = 0;
			for(var i : int = 0; i < values.length; i++)
			{
				total += values[i];
			}
			return total / values.length;
		}
		
		public function Graph(title:String, values:Vector.<Number>, displayWidth:Number=-1, displayHeight:Number=-1, graphWidth:int = 5)
		{
			super();
			this.title = title;
			this.graphWidth = graphWidth;
			this.displayHeight = displayHeight;
			this.displayWidth = displayWidth;
			this.graphHolder = new Sprite();
			var titleTxt : TextField = new TextField();
			titleTxt.text = title;
			
			this.addChild(graphHolder);
			this.addChild(titleTxt);
			titleTxt.x = (displayWidth - titleTxt.width)/2;
			titleTxt.y = -titleTxt.height;
		}
		
		public function Update(event:Event = null):void
		{
			var copy : Vector.<Number> = SliceAndSort(values.length-graphWidth, values.length-1);
			max = copy[0];
			min = copy[copy.length-1];
			
			graphHolder.graphics.clear();
			graphHolder.graphics.lineStyle(1,0xFFFFFF);
			graphHolder.graphics.moveTo(0,max-min);
			graphHolder.graphics.lineTo(0,0);
			var xOrigin : Number = min < 0 ? -min : 0;
			graphHolder.graphics.moveTo(0, xOrigin);
			graphHolder.graphics.lineTo(graphWidth,0);
			
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
			if(endIndex >= copy.length)
			{
				endIndex = copy.length-1;
			}
			copy = copy.slice(startIndex, endIndex);
			return copy;
		}
		
		private var title : String;
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
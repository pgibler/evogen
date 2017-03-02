package org.gibler.util
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
		
		public function GetVarianceInRange(startIndex:Number=0, endIndex:Number=-1):Number
		{
			var mean : Number = Mean;
			var variance : Number = 0;
			Slice(startIndex, endIndex).forEach(function(val:Number, index:int, vec:Vector.<Number>):void
			{
				variance += Math.pow(val - mean, 2);
			});
			return variance / values.length-1;
		}
		
		public function GetStandardDeviationInRange(startIndex:Number=0, endIndex:Number=-1):Number
		{
			return Math.sqrt(GetVarianceInRange(startIndex, endIndex));
		}
		
		public function GetMaxInRange(startIndex:Number=0, endIndex:Number=-1):Number
		{
			var copy : Vector.<Number> = SliceAndSort(startIndex, endIndex);
			return copy[0];
		}
		
		public function GetMeanInRange(startIndex:Number=0, endIndex:Number=-1):Number
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
			this.values = values;
			var titleTxt : TextField = new TextField();
			titleTxt.text = title;
			var fmt : TextFormat = new TextFormat();
			fmt.font = "Calibri";
			titleTxt.setTextFormat(fmt);
			
			this.addChild(graphHolder);
			this.addChild(titleTxt);
			titleTxt.background = true;
			titleTxt.backgroundColor = 0xFFFFFF;
			titleTxt.height = 20;
			titleTxt.x = (displayWidth - titleTxt.width)/2;
			titleTxt.y = -titleTxt.height;
		}
		
		public function Update(event:Event = null):void
		{
			var start : Number = values.length >= graphWidth ? values.length-graphWidth : 0;
			var valuesCopy : Vector.<Number> = SliceAndSort();
			var copy : Vector.<Number> = Slice(start,values.length);
			var sortedCopy : Vector.<Number> = SliceAndSort(start, values.length);
			
			if(valuesCopy.length > 0)
			{
				min = valuesCopy[0];
				max = valuesCopy[valuesCopy.length-1];
			}
			var hr : Number = displayHeight / (max-min);
			var yOffset : Number = displayHeight;
			
			RenderBackgroundBox();
			
			var g : Graphics = graphHolder.graphics;
			g.lineStyle(1,0xFF0000);
			if(copy.length > 0)
			{
				var indexWidth : Number = displayWidth / graphWidth;
				g.moveTo(0, yOffset+hr*(-copy[0] + min));
				for(var i : int = 1; i < copy.length; i++)
				{
					var xx : Number = i * indexWidth;
					var startY : Number = -copy[i] + min;
					var yy : Number = hr*startY;
					g.lineTo(xx, yOffset+yy);
				}
			}
			
			//graphHolder.width = displayWidth;
			//graphHolder.height = displayHeight;
		}
		
		public function RenderBackgroundBox():void
		{
			var g : Graphics = graphHolder.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRect(0,0,displayWidth,displayHeight);
			g.endFill();
		}
		
		private function SliceAndSort(startIndex:Number=0, endIndex:Number=-1):Vector.<Number>
		{
			var copy : Vector.<Number> = Slice(startIndex, endIndex);
			copy.sort(function(val1:Number, val2:Number):Number
			{
				return val1 - val2;
			});
			return copy;
		}
		
		private function Slice(startIndex:Number=0, endIndex:Number=-1):Vector.<Number>
		{
			if(endIndex == -1 || endIndex > values.length)
			{
				endIndex = values.length;
			}
			if(endIndex < startIndex && endIndex != -1)
			{
				throw new Error("End index must be larger than start index");
			}
			var copy : Vector.<Number> = values.slice(startIndex, endIndex);
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
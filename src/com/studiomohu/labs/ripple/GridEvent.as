package com.studiomohu.labs.ripple 
{
	import flash.events.Event;

	/**
	 * @author art
	 */
	public class GridEvent extends Event 
	{
		public static const HIT : String = "hit";
		public var x : int;
		public var y : int;
		public function GridEvent (type : String, x : int, y : int, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			this.x = x;			this.y = y;
		}
		override public function clone() : Event
		{
			return new GridEvent( type, x, y, bubbles, cancelable ) as GridEvent;
		}
	}
}

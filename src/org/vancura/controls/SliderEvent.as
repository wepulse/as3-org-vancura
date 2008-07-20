package org.vancura.controls {
	import flash.events.Event;

	
	
	/**
	 * Slider event.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jul 17, 2008
	 */
	public class SliderEvent extends Event {

		
		
		public static const REFRESH:String = 'onRefresh';
		public var thumbPos:Number;

		
		
		public function SliderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, tp:Number = 0) {
			thumbPos = tp;
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new SliderEvent(type, bubbles, cancelable);
		}

		
		
		public override function toString():String {
			return formatToString('SliderEvent', 'type', 'bubbles', 'cancelable', 'thumbPos');
		}
	}
}

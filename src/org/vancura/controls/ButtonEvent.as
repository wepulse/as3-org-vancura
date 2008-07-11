package org.vancura.controls {
	import flash.events.Event;

	
	
	/**
	 * Button event.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 26, 2008
	 */
	public class ButtonEvent extends Event {

		
		
		public static const OVER:String = 'onOver';
		public static const DRAG_OVER:String = 'onDragOver';
		public static const DRAG_OUT:String = 'onDragOut';
		public static const DRAG_CONFIRM:String = 'onDragConfirm';
		public static const ROLL_OUT:String = 'onRollOut';
		public static const PRESS:String = 'onPress';
		public static const RELEASE_INSIDE:String = 'onReleaseInside';
		public static const RELEASE_OUTSIDE:String = 'onReleaseOutside';

		
		
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable);
		}

		
		
		public override function toString():String {
			return formatToString('ButtonEvent', 'type', 'bubbles', 'cancelable');
		}
	}
}

package org.vancura.util {
	import flash.events.*;	



	/**
	 * Remove multiple event listeners from a target.
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Mar 22, 2008
	 * 
	 * @param obj Target EventDispatcher
	 * @param params Multiple Objects with pairs {event:..., method:...}
	 */
	public function removeEventListeners(obj:EventDispatcher, ... params):void {
		for each(var i:Object in params) {
			if(i.event == undefined) throw new Error('Event undefined');
			if(i.method == undefined) throw new Error('Method undefined');
			obj.removeEventListener(i.event, i.method);
		}
	}
}

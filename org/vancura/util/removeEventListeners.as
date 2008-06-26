package org.vancura.util {



	import flash.events.*;



	/*
		Method: removeEventListeners
		*Remove multiple event listeners from a target.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 22.03.2008

		Parameters:

			obj		- Target EventDispatcher
			params	- Multiple Objects with pairs { event: ..., method: ... }

		- TODO: Write documentation
	*/
	public function removeEventListeners( obj:EventDispatcher, ... params ):void {
		for each( var i:Object in params ) {
			if( i.event == undefined ) throw new Error( 'Event undefined' );
			if( i.method == undefined ) throw new Error( 'Method undefined' );
			obj.removeEventListener( i.event, i.method );
		}
	}



}

package org.vancura.util {



	import flash.events.*;



	/*
		Method: addEventListeners
		*Add multiple event listeners to a target.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 22.03.2008

		Parameters:

			obj		- Target EventDispatcher
			params	- Multiple Objects with pairs { event: ..., method: ... }

		- TODO: Write documentation
	*/
	public function addEventListeners( obj:EventDispatcher, ... params ):void {
		for each( var i:Object in params ) {
			if( i.event == undefined ) throw new Error( 'Event undefined' );
			if( i.method == undefined ) throw new Error( 'Method undefined' );
			obj.addEventListener( i.event, i.method );
		}
	}



}

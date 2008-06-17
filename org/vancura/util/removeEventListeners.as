/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.util {



	import flash.events.*;



	/**
	 *	Remove list of event listeners.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 22.03.2008
	 *	@param obj Event dispatcher
	 */
	public function removeEventListeners( obj:EventDispatcher, ... params ):void {
		for each( var i:Object in params ) {
			if( i.event == undefined ) throw new Error( 'Event undefined' );
			if( i.method == undefined ) throw new Error( 'Method undefined' );
			obj.removeEventListener( i.event, i.method );
		}
	}



}

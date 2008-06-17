/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.util {



	import org.osflash.thunderbolt.Logger;



	/**
	 *	Assign properties from params to obj
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 21.03.2008
	 *	@param obj Target object
	 *	@param params Source object
	 */
	public function assign( obj:Object, params:Object ):void {
		for( var i:String in params ) {
			obj[ i ] = params[ i ];
		}
	}



}

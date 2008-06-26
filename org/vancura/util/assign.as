package org.vancura.util {



	import org.osflash.thunderbolt.Logger;



	/*
		Method: assign
		*Assign properties from params to Object.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 21.03.2008

		Parameters:

			obj		- Target Object
			params	- Source Object

		- TODO: Write documentation
	*/
	public function assign( obj:Object, params:Object ):void {
		for( var i:String in params ) {
			obj[ i ] = params[ i ];
		}
	}



}

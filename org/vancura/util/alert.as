/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.util {
	
	
	
	import org.osflash.thunderbolt.Logger
	
	
	
	/**
	 *	Alerter.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 09.03.2008
	 *	@param message Message
	 */
	public function alert( message:String = 'Unknown error' ):void {
		trace( '-----------------------------------------------------------------------------------------------------------------------------------' );
		trace( message );
		trace( '-----------------------------------------------------------------------------------------------------------------------------------' );
		Logger.error( message );
	}
		
		
		
}

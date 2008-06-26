package org.vancura.util {



	import org.osflash.thunderbolt.Logger



	/*
		Method: alert
		*Alerter.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 09.03.2008

		Parameters:

			message		- Message to display

		- TODO: Write documentation
	*/
	public function alert( message:String = 'Unknown error' ):void {
		trace( '-----------------------------------------------------------------------------------------------------------------------------------' );
		trace( message );
		trace( '-----------------------------------------------------------------------------------------------------------------------------------' );
		Logger.error( message );
	}



}

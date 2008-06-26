package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/*
		Class: MenuService
		*Remoting service for menu calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class MenuService extends RemotingService {



		private var __menuData:Array;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function MenuService() {
			super();
			__menuData = new Array();
		}



		public function loadMainMenu( id:String ):void {
			try {
				var r:Responder = new Responder( onLoadResult, onFault );
				__gateway.call( 'menu.load', r, __apiKey, __sessID, id );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while loading menu (...)\n%s', e.message ) ); }
		}



		public function getMenuItemByPath( p:String ):Object {
			for each( var i:Object in __menuData ) {
				if( i.pathalias == p ) return i;
			}
			throw new RemotingException( sprintf( 'Error finding menu item "%s"', p ) );
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function onLoadResult( result:Object ):void {
			for each( var o:Object in result.menu ) __menuData.push( o );
			dispatchEvent( new RemotingEvent( RemotingEvent.MENU_LOADED, false, false, result ) );
		}



	}



}

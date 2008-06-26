package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/*
		Class: PageService
		*Remoting service for page calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class PageService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function PageService() {
			super();
		}



		public function loadPageByNID( nid:int ):void {
			try {
				__gateway.call( 'node.load', new Responder( onLoadResult, onFault ), __apiKey, __sessID, nid );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while loading page "%s" (...)\n%s', nid, e.message ) ); }
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function onLoadResult( result:Object ):void {
			dispatchEvent( new RemotingEvent( RemotingEvent.PAGE_LOADED, false, false, result ) );
		}



	}



}

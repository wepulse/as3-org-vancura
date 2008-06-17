/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/**
	 *	Remoting service for page calls.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 14.01.2008
	 */
	public class PageService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Create new page service.
		*	@param
		*/
		public function PageService() {
			super();
		}



		/**
		*	Load page by its node ID.
		*	@param nid Node ID
		*/
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

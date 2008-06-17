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
	 *	Remoting service for view calls.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 14.01.2008
	 */
	public class ViewService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Create new view service.
		*/
		public function ViewService() {
			super();
		}



		/**
		*	Load view by it's name.
		*	@param name View name
		*/
		public function loadViewByName( name:String ):void {
			try {
				var r:Responder = new Responder( onLoadResult, onFault );
				__gateway.call( 'views.getView', r, __apiKey, __sessID, name );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while loading view "%s" (...)\n%s', name, e.message ) ); }
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function onLoadResult( result:Object ):void {
			dispatchEvent( new RemotingEvent( RemotingEvent.VIEW_LOADED, false, false, result ) );
		}



	}



}

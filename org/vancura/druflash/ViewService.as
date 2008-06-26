package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/*
		Class: ViewService
		*Remoting service for view calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class ViewService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function ViewService() {
			super();
		}



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

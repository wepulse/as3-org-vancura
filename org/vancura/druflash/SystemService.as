package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/*
		Class: SystemService
		*Remoting service for system calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class SystemService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function SystemService() {
			super();
		}



		public function requestSessID():void {
			try {
				var r:Responder = new Responder( __onGotSessID, onFault );
				__gateway.call( 'system.connect', r, __apiKey );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while requesting sessID (...)\n%s', e.message ) ); }
		}



		public function sendMail( mailkey:String, to:String, subject:String, body:String, from:String, headers:Array ):void {
			if( __sessID == '' ) throw new Error( 'sessID not ready yet, call requestSessID() first' );
			if( mailkey == '' ) throw new Error( 'Mailkey required' );
			if( to == '' ) throw new Error( 'Subject required' );
			if( subject == '' ) throw new Error( 'Subject required' );
			if( body == '' ) throw new Error( 'Body required' );

			try {
				var r:Responder = new Responder( __onGotSendMailResponse, onFault );
				__gateway.call( 'system.mail', r, __apiKey, __sessID, mailkey, to, subject, body, from, headers );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while sending mail (...)\n%s', e.message ) ); }
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function __onGotSessID( result:Object ):void {
			__sessID = result.sessid;
			dispatchEvent( new RemotingEvent( RemotingEvent.SYSTEM_GOT_SESSID, false, false, { sessID: __sessID } ) );
		}



		private function __onGotSendMailResponse( result:Object ):void {
			dispatchEvent( new RemotingEvent( RemotingEvent.SYSTEM_SEND_MAIL_DONE ) );
		}



	}



}

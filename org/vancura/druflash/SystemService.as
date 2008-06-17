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
	 *	Remoting service for system calls.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 14.01.2008
	 */
	public class SystemService extends RemotingService {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Create new system service.
		*/
		public function SystemService() {
			super();
		}



		/**
		*	Request session id.
		*/
		public function requestSessID():void {
			try {
				var r:Responder = new Responder( __onGotSessID, onFault );
				__gateway.call( 'system.connect', r, __apiKey );
			}
			catch( e:Error ) { throw new RemotingException( sprintf( 'Error while requesting sessID (...)\n%s', e.message ) ); }
		}



		/**
		*	Send a mail.
		*	@param mailkey Mailkey
		*	@param to To
		*	@param subject Subject
		*	@param body Body
		*	@param from From
		*	@param headers Headers
		*/
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

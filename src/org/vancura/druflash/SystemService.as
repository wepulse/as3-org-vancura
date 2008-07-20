package org.vancura.druflash {
	import flash.events.*;
	import flash.net.*;
	
	import de.popforge.utils.sprintf;	

	
	
	/**
	 * Remoting service aimed to help system calls.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class SystemService extends RemotingService {

		
		
		/**
		 * System service constructor.
		 */
		public function SystemService() {
			super();
		}

		
		
		/**
		 * Request session ID.
		 * @throws RemotingException if something goes wrong.
		 */
		public function requestSessID():void {
			try {
				var r:Responder = new Responder(_onGotSessID, onFault);
				$gateway.call('system.connect', r, $apiKey);
			}
			catch(err:Error) {
				throw new RemotingException(sprintf('Error while requesting sessID (...)\n%s', err.message)); 
			}
		}

		
		
		/**
		 * Send a mail.
		 * @param body Body.
		 * @param from From address.
		 * @param headers Headers.
		 * @param mailkey Mailkey.
		 * @param subject Subject.
		 * @param to To address.
		 * @throws Error if session ID is not specified.
		 * @throws Error if mailkey is not specified.
		 * @throws Error if subject is not specified.
		 * @throws Error if to address is not specified.
		 * @throws Error if body is not specified.
		 * @throws RemotingException if something goes wrong.
		 */
		public function sendMail(mailkey:String, to:String, subject:String, body:String, from:String, headers:Array):void {
			if($sessID == '') throw new Error('sessID not ready yet, call requestSessID() first');
			if(mailkey == '') throw new Error('Mailkey required');
			if(to == '') throw new Error('To address required');
			if(subject == '') throw new Error('Subject required');
			if(body == '') throw new Error('Body required');

			try {
				var r:Responder = new Responder(_onGotSendMailResponse, onFault);
				$gateway.call('system.mail', r, $apiKey, $sessID, mailkey, to, subject, body, from, headers);
			}
			catch(err:Error) {
				throw new RemotingException(sprintf('Error while sending mail (...)\n%s', err.message)); 
			}
		}

		
		
		private function _onGotSessID(result:Object):void {
			$sessID = result.sessid;
			dispatchEvent(new RemotingEvent(RemotingEvent.SYSTEM_GOT_SESSID, false, false, {sessID:$sessID}));
		}

		
		
		private function _onGotSendMailResponse(result:Object):void {
			dispatchEvent(new RemotingEvent(RemotingEvent.SYSTEM_SEND_MAIL_DONE, false, false, result));
		}
	}
}

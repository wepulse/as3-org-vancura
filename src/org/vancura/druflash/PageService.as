package org.vancura.druflash {
	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;

	
	
	/**
	 * Remoting service amied to help page calls.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class PageService extends RemotingService {

		
		
		public function PageService() {
			super();
		}

		
		
		public function loadPageByNID(nid:int):void {
			try {
				$gateway.call('node.load', new Responder(onLoadResult, onFault), $apiKey, $sessID, nid);
			}
			catch(err:Error) {
				throw new RemotingException(sprintf('Error while loading page "%s" (...)\n%s', nid, err.message));
			}
		}

		
		
		private function onLoadResult(result:Object):void {
			dispatchEvent(new RemotingEvent(RemotingEvent.PAGE_LOADED, false, false, result));
		}
	}
}

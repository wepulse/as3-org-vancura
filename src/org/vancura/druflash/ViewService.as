package org.vancura.druflash {
	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;

	
	
	/**
	 * Remoting service aimed to help view calls.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class ViewService extends RemotingService {

		
		
		public function ViewService() {
			super();
		}

		
		
		public function loadViewByName(name:String):void {
			try {
				var r:Responder = new Responder(onLoadResult, onFault);
				$gateway.call('views.getView', r, $apiKey, $sessID, name);
			}
			catch(err:Error) {
				throw new RemotingException(sprintf('Error while loading view "%s" (...)\n%s', name, err.message)); 
			}
		}

		
		
		private function onLoadResult(result:Object):void {
			dispatchEvent(new RemotingEvent(RemotingEvent.VIEW_LOADED, false, false, result));
		}
	}
}

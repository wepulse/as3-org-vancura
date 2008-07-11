package org.vancura.druflash {
	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;

	
	
	/**
	 * Remoting service aimed to help menu calls.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class MenuService extends RemotingService {

		
		
		private var _menuData:Array;

		
		
		public function MenuService() {
			super();
			_menuData = new Array();
		}

		
		
		public function loadMainMenu(id:String):void {
			try {
				var r:Responder = new Responder(onLoadResult, onFault);
				$gateway.call('menu.load', r, $apiKey, $sessID, id);
			}
			catch(err:Error) {
				throw new RemotingException(sprintf('Error while loading menu (...)\n%s', err.message));
			}
		}

		
		
		public function getMenuItemByPath(p:String):Object {
			for each(var i:Object in _menuData) {
				if(i.pathalias == p) return i;
			}
			throw new RemotingException(sprintf('Error finding menu item "%s"', p));
		}

		
		
		private function onLoadResult(result:Object):void {
			for each(var o:Object in result.menu) _menuData.push(o);
			dispatchEvent(new RemotingEvent(RemotingEvent.MENU_LOADED, false, false, result));
		}
	}
}

package org.vancura.druflash {
	import flash.events.*;
	import flash.net.*;
	
	import de.popforge.utils.sprintf;	

	
	
	/**
	 * Remoting service aimed to help global calls.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class RemotingService extends EventDispatcher {

		
		
		protected static var $gateway:NetConnection;
		protected static var $sessID:String;
		protected static var $serverPath:String;
		protected static var $gatewayPath:String;
		protected static var $apiKey:String;
		private static var _isInited:Boolean;
		private static var _isDestroyed:Boolean; 
		private static var _isConnected:Boolean;
		private static var _isConnecting:Boolean;

		
		
		public static function init(config:Object):void {
			if(config.gatewayPath == undefined) throw new RemotingException('Gateway path not defined');
			if(config.serverPath == undefined) throw new RemotingException('Server path not defined');
			if(config.apiKey == undefined) throw new RemotingException('API key not defined');

			$gatewayPath = config.gatewayPath;
			$serverPath = config.serverPath;
			$apiKey = config.apiKey;

			_isInited = true;
		}

		
		
		public function RemotingService() {
			if(!_isInited) throw new RemotingException('Remoting not inited, call RemotingService.init() first');
			if(!_isConnecting && !_isConnected) {
				try {
					_isConnecting = true;
					$gateway = new NetConnection();
					$gateway.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusHandler, false, 0, true);
					$gateway.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityErrorHandler, false, 0, true);
					$gateway.connect($gatewayPath);
				}
				catch(event:Error) {
					throw new RemotingException(sprintf('Error initializing remoting (...)\n%s', event.message)); 
				}
			}
		}

		
		
		public function destroy():void {
			$gateway.close();
			$gateway.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusHandler);
			$gateway.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityErrorHandler);
			_isDestroyed = true;
		}

		
		
		public function get serverPath():String {
			return $serverPath;
		}

		
		
		public function get gatewayPath():String {
			return $gatewayPath;
		}

		
		
		public function set sessID(value:String):void {
			$sessID = value;
		}

		
		
		protected function onFault(fault:Object):void {
			dispatchEvent(new RemotingEvent(RemotingEvent.FAULT, false, false, null, fault.description));
		}

		
		
		private function _onSecurityErrorHandler(event:SecurityErrorEvent):void {
			dispatchEvent(new RemotingEvent(RemotingEvent.SECURITY_ERROR, false, false, null, event.text));
		}

		
		
		private function _onNetStatusHandler(event:NetStatusEvent):void {
			if(event.info.code == RemotingEvent.CONNECT_SUCCESS) {
				_isConnected = true;
				_isConnecting = true;
			}
			dispatchEvent(new RemotingEvent(event.info.code));
		}
	}
}

package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;
	import flash.net.*;



	/*
		Class: RemotingService
		*Remoting service for global calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class RemotingService extends EventDispatcher {



		protected static var __gateway:NetConnection;
		protected static var __sessID:String;
		protected static var __serverPath:String;
		protected static var __gatewayPath:String;
		protected static var __apiKey:String;

		private static var __isInited:Boolean;
		private static var __isDestroyed:Boolean; // TODO: add to all classes
		private static var __isConnected:Boolean;
		private static var __isConnecting:Boolean;



		// --------------------------------------------- STATIC METHODS ---------------------------------------------



		public static function init( config:Object ):void {
			if( config.gatewayPath == undefined ) throw new RemotingException( 'Gateway path not defined' );
			if( config.serverPath == undefined ) throw new RemotingException( 'Server path not defined' );
			if( config.apiKey == undefined ) throw new RemotingException( 'API key not defined' );

			__gatewayPath = config.gatewayPath;
			__serverPath = config.serverPath;
			__apiKey = config.apiKey;

			__isInited = true;
		}



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function RemotingService() {
			if( !__isInited ) throw new RemotingException( 'Remoting not inited, call RemotingService.init() first' );
			if( !__isConnecting && !__isConnected ) {
				try {
					__isConnecting = true;
					__gateway = new NetConnection();
					__gateway.addEventListener( NetStatusEvent.NET_STATUS, __onNetStatusHandler );
	            	__gateway.addEventListener( SecurityErrorEvent.SECURITY_ERROR, __onSecurityErrorHandler );
					__gateway.connect( __gatewayPath );
				}
				catch( e:Error ) { throw new RemotingException( sprintf( 'Error initializing remoting (...)\n%s', e.message ) ); }
			}
		}



		public function destroy():void {
			__gateway.close();
			__gateway.removeEventListener( NetStatusEvent.NET_STATUS, __onNetStatusHandler );
			__gateway.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, __onSecurityErrorHandler );
			__isDestroyed = true;
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		public function get serverPath():String {
			return __serverPath;
		}



		public function get gatewayPath():String {
			return __gatewayPath;
		}



		public function set sessID( value:String ):void {
			__sessID = value;
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		protected function onFault( fault:Object ):void {
			dispatchEvent( new RemotingEvent( RemotingEvent.FAULT, false, false, null, fault.description ) );
		}



		private function __onSecurityErrorHandler( event:SecurityErrorEvent ):void {
			dispatchEvent( new RemotingEvent( RemotingEvent.SECURITY_ERROR, false, false, null, event.text ) );
		}



		private function __onNetStatusHandler( event:NetStatusEvent ):void {
			if( event.info.code == RemotingEvent.CONNECT_SUCCESS ) {
				__isConnected = true;
				__isConnecting = true;
			}
			dispatchEvent( new RemotingEvent( event.info.code ) );
		}



	}



}

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
	 *	Remoting service for global calls.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 14.01.2008
	 */
	public class RemotingService extends EventDispatcher {



		/** Gateway connection */
		protected static var __gateway:NetConnection;

		/** Session ID */
		protected static var __sessID:String;

		/** Server path */
		protected static var __serverPath:String;

		/** Gateway path */
		protected static var __gatewayPath:String;

		/** API key */
		protected static var __apiKey:String;

		private static var __isInited:Boolean;
		private static var __isDestroyed:Boolean; // TODO: add to all classes
		private static var __isConnected:Boolean;
		private static var __isConnecting:Boolean;



		// --------------------------------------------- STATIC METHODS ---------------------------------------------



		/**
		*	Init connection.
		*	@param config Config data
		*/
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



		/**
		*	Create new remoting service.
		*/
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



		/**
		*	Destroy remoting service.
		*/
		public function destroy():void {
			__gateway.close();
			__gateway.removeEventListener( NetStatusEvent.NET_STATUS, __onNetStatusHandler );
			__gateway.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, __onSecurityErrorHandler );
			__isDestroyed = true;
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		/**
		*	Get server path.
		*	@return Server path
		*/
		public function get serverPath():String {
			return __serverPath;
		}



		/**
		*	Get gateway path.
		*	@return Gateway path
		*/
		public function get gatewayPath():String {
			return __gatewayPath;
		}



		/**
		*	Set session ID.
		*	@param value Session ID
		*/
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

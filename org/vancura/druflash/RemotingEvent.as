package org.vancura.druflash {



	import de.popforge.utils.sprintf;

	import flash.events.*;



	/*
		Class: RemotingEvent
		*Remoting event filled with global remoting information.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class RemotingEvent extends Event {



		public static const BAD_PERSISTENC:String = 'SharedObject.BadPersistenc';
		public static const CALL_BAD_VERSION:String = 'NetConnection.Call.BadVersion';
		public static const CALL_FAILED:String = 'NetConnection.Call.Failed';
		public static const CALL_PROHIBITED:String = 'NetConnection.Call.Prohibited';
		public static const CONNECT_APP_SHUTDOWN:String = 'NetConnection.Connect.AppShutdown';
		public static const CONNECT_FAILED:String = 'NetConnection.Connect.Failed';
		public static const CONNECT_INVALID_APP:String = 'NetConnection.Connect.InvalidApp';
		public static const CONNECT_REJECTED:String = 'NetConnection.Connect.Rejected';
		public static const CONNECT_SUCCESS:String = 'NetConnection.Connect.Success';
		public static const FAILED:String = 'NetStream.Failed';
		public static const FAULT:String = 'onFault';
		public static const FLUSH_FAILED:String = 'SharedObject.Flush.Failed';
		public static const PLAY_FAILED:String = 'NetStream.Play.Failed';
		public static const PLAY_FILE_STRUCTURE_INVALID:String = 'NetStream.Play.FileStructureInvalid';
		public static const PLAY_INSUFFICIENT_BANDWIDTH:String = 'NetStream.Play.InsufficientBW';
		public static const PLAY_NO_SUPPORTED_TRACK_FOUND:String = 'NetStream.Play.NoSupportedTrackFound';
		public static const PLAY_STREAM_NOT_FOUND:String = 'NetStream.Play.StreamNotFound';
		public static const PUBLISH_BAD_NAME:String = 'NetStream.Publish.BadName';
		public static const RECORD_FAILED:String = 'NetStream.Record.Failed';
		public static const RECORD_NO_ACCESS:String = 'NetStream.Record.NoAccess';
		public static const SECURITY_ERROR:String = 'onSecurityError';
		public static const SEEK_FAILED:String = 'NetStream.Seek.Failed';
		public static const SEEK_INVALID_TIME:String = 'NetStream.Seek.InvalidTime';
		public static const URI_MISMATCH:String = 'SharedObject.UriMismatch';

		public static const MENU_LOADED:String = 'onMenuLoaded';
		public static const PAGE_LOADED:String = 'onPageLoaded';
		public static const SYSTEM_GOT_SESSID:String = 'onSystemGotSessID';
		public static const VIEW_LOADED:String = 'onViewLoaded';
		public static const SYSTEM_SEND_MAIL_DONE:String = 'onSystemSendMailDone';

		public var description:String;
		public var data:Object;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function RemotingEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, remotingData:Object = null, remotingDescription:String = null ) {
			var isError:Boolean = true;

			switch( type ) {
				case BAD_PERSISTENC: description = 'A request was made for a shared object with persistence flags, but the request cannot be granted because the object has already been created with different flags.'; break;
				case CALL_BAD_VERSION: description = 'Packet encoded in an unidentified format.'; break;
				case CALL_FAILED: description = 'The NetConnection.call method was not able to invoke the server-side method or command.'; break;
				case CALL_PROHIBITED: description = 'An Action Message Format (AMF) operation is prevented for security reasons. Either the AMF URL is not in the same domain as the file containing the code calling the NetConnection.call() method, or the AMF server does not have a policy file that trusts the domain of the the file containing the code calling the NetConnection.call() method.'; break;
				case CONNECT_APP_SHUTDOWN: description = 'The specified application is shutting down.'; break;
				case CONNECT_FAILED: description = 'The connection attempt failed.'; break;
				case CONNECT_INVALID_APP: description = 'The application name specified during connect is invalid.'; break;
				case CONNECT_REJECTED: description = 'The connection attempt did not have permission to access the application.'; break;
				case CONNECT_SUCCESS: isError = false; description = 'The connection attempt succeeded.';
				case FAILED: description = 'Flash Media Server only. An error has occurred for a reason other than those listed in other event codes.'; break;
				case FLUSH_FAILED: description = 'The "pending" status is resolved, but the SharedObject.flush() failed.'; break;
				case PLAY_FAILED: description = 'An error has occurred in playback for a reason other than those listed elsewhere in this table, such as the subscriber not having read access.'; break;
				case PLAY_FILE_STRUCTURE_INVALID: description = 'The application detects an invalid file structure and will not try to play this type of file. For AIR and for Flash Player 9 Update 3 and later.'; break;
				case PLAY_INSUFFICIENT_BANDWIDTH: description = 'Flash Media Server only. The client does not have sufficient bandwidth to play the data at normal speed.'; break;
				case PLAY_NO_SUPPORTED_TRACK_FOUND: description = 'The application does not detect any supported tracks (video, audio or data) and will not try to play the file. For AIR and for Flash Player 9 Update 3 and later.'; break;
				case PLAY_STREAM_NOT_FOUND: description = 'The FLV passed to the play() method can\'t be found.'; break;
				case PUBLISH_BAD_NAME: description = 'Attempt to publish a stream which is already being published by someone else.'; break;
				case RECORD_FAILED: description = 'An attempt to record a stream failed.'; break;
				case RECORD_NO_ACCESS: description = 'Attempt to record a stream that is still playing or the client has no access right.'; break;
				case SEEK_FAILED: description = 'The seek fails, which happens if the stream is not seekable.'; break;
				case SEEK_INVALID_TIME: description = 'For video downloaded with progressive download, the user has tried to seek or play past the end of the video data that has downloaded thus far, or past the end of the video once the entire file has downloaded. The message.details property contains a time code that indicates the last valid position to which the user can seek.'; break;
				case URI_MISMATCH: description = 'An attempt was made to connect to a NetConnection object that has a different URI (URL) than the shared object.'; break;
				default: description = sprintf( 'Unknown error (code = %s)', type );
			}

			if( remotingDescription != null ) description = remotingDescription;
			data = remotingData;
			super( type, bubbles, cancelable );
		}



		public override function clone():Event {
			return new RemotingEvent( type, bubbles, cancelable );
		}



		public override function toString():String {
			return formatToString( 'ViewEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'data', 'description' );
		}



	}



}

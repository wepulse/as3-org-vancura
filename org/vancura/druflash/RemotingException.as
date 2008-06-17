/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.druflash {



	/**
	 *	Remoting exception for page calls.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 14.01.2008
	 */
	public class RemotingException extends Error {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Cast a remoting exception.
		*	@param message Message
		*	@param id ID
		*/
		public function RemotingException( message:String = 'Unknown remoting exception', id:int = 0 ) {
			super( message, id );
		}



	}



}
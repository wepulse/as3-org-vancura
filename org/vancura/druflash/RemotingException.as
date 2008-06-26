package org.vancura.druflash {



	/*
		Class: RemotingException
		*Remoting exception for page calls.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 14.01.2008

		- TODO: Write documentation
	*/
	public class RemotingException extends Error {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function RemotingException( message:String = 'Unknown remoting exception', id:int = 0 ) {
			super( message, id );
		}



	}



}
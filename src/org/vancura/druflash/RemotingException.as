package org.vancura.druflash {

	
	
	/**
	 * Remoting exception.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jan 14, 2008
	 */
	public class RemotingException extends Error {

		
		
		public function RemotingException(msg:String = 'Unknown remoting exception', id:int = 0) {
			super(msg, id);
		}
	}
}
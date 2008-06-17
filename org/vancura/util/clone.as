/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.util {



	import flash.utils.ByteArray;



	/**
	 *	Object cloner.
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 17.06.2008
	 *	@param source Source object
	 *	@return Cloned object
	 */
	public function clone( source:* ):Object {
		var copier:ByteArray = new ByteArray();
		copier.writeObject( source as Object );
		copier.position = 0;
		var result:Object = copier.readObject();
		return result;
    }



}

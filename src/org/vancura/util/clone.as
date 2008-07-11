package org.vancura.util {
	import flash.utils.ByteArray;



	/**
	 * Object cloner.
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 17, 2008
	 * 
	 * @param source Source Object
	 * @return Cloned Object
	 */
	public function clone(source:*):Object {
		var copier:ByteArray = new ByteArray();
		copier.writeObject(source as Object);
		copier.position = 0;
		var result:Object = copier.readObject();
		return result;
	}
}

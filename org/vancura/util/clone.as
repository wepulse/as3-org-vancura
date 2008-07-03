package org.vancura.util {



	import flash.utils.ByteArray;



	/*
		Method: clone
		*Object cloner.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 17.06.2008

		Parameters:

			source		- Source Object

		Returns:

			Cloned Object

		- TODO: Write documentation
	*/
	public function clone( source:* ):Object {
		var copier:ByteArray = new ByteArray();
		copier.writeObject( source as Object );
		copier.position = 0;
		var result:Object = copier.readObject();
		return result;
    }



}

package org.vancura.util {



	/*
		Method: assign
		*Assign properties from params to Object.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 21.03.2008

		Parameters:

			obj		- Target Object
			params	- Source Object
			
		Returns:
				
			Resulting Object

		- TODO: Write documentation
	*/
	public function assign(obj:Object, params:Object):Object {
		var out:Object = (obj);
		for(var i:String in params) out[i] = params[i];
		return out;
	}
}

package org.vancura.util {



	import flash.display.*;



	/*
		Method: removeChildren
		*Remove children from DisplayObject.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 22.03.2008

		Parameters:

			obj			- Target DisplayObject
			children	- Children

		- TODO: Write documentation
	*/
	public function removeChildren( obj:*, ... children:Array ):void {
		for each( var i:DisplayObject in children ) {
			obj.removeChild( i );
		}
	}



}

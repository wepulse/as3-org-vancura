/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.util {



	import flash.display.*;



	/**
	 * Add children to DisplayObject.
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * @since 22.03.2008
	 * @param obj Event dispatcher
	 */
	public function addChildren( obj:*, ... children:Array ):void {
		for each( var i:DisplayObject in children ) {
			obj.addChild( i );
		}
	}



}

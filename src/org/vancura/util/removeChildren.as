package org.vancura.util {
	import flash.display.*;



	/**
	 * Remove children from DisplayObject.
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Mar 22, 2008
	 * 
	 * @param children Children
	 * @param obj Target DisplayObject
	 */
	public function removeChildren(obj:*, ... children:Array):void {
		for each(var i:DisplayObject in children) {
			obj.removeChild(i);
		}
	}
}

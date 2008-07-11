package org.vancura.controls {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.vancura.graphics.Bitmapping;
	import org.vancura.graphics.MorphSprite;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;	

	
	
	/**
	 * Thumbnail control.
	 * 
	 * TODO: Write documentation
	 * TODO: Clean
	 * FIXME: Inactive color = 0xb7bdb0
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Thumbnail extends MorphSprite {

		
		
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defFrameSkin:BitmapData = null;
		protected var $frameBM:Bitmap;

		
		
		public function Thumbnail(c:Object = null) {
			super();

			var bd:BitmapData;

			// convert template data to BitmapData
			if(c && c.frame) bd = Bitmapping.embed2BD(c.frame);
			else {
				// frame parameter is not defined, try to get it from default settings
				if(defFrameSkin == null) throw new Error('Thumbnail frame is not defined.');
				else bd = defFrameSkin;
				if(c == null) c = new Object();
			}

			// set initial values
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;

			// get frame image
			$frameBM = new Bitmap(bd);

			// add to display list
			addChildren(this, $frameBM);
			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.cacheAsBitmap = true;
			this.mask = (c.mask != undefined) ? c.mask : null;
		}

		
		
		public function destroy():void {
			// remove from display list
			removeChildren(this, $frameBM);
		}
	}
}

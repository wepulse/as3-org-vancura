package org.vancura.graphics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;	

	
	
	/*
	Class: QBitmap
	 *Quick creation of Bitmap with initial data.*

	Author: Vaclav Vancura <http://vaclav.vancura.org>

	Since: 21.03.2008
	 */
	public class QBitmap extends Bitmap {

		
		
		public function QBitmap(c:Object = null) {
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			super();

			// Bitmap overrides and custom settings:
			if(c.embed) {
				if(c.embed is Bitmap) this.bitmapData = c.embed.bitmapData;
				else if(c.embed is BitmapData) this.bitmapData = c.embed;
				else throw new Error('Invalid embed object');
			}

			// Bitmap overrides:
			if(c.bitmapData != undefined) this.bitmapData = c.bitmapData;
			if(c.pixelSnapping != undefined) this.pixelSnapping = c.pixelSnapping;
			if(c.smoothing != undefined) this.smoothing = c.smoothing;

			// DisplayObject overrides:
			if(c.accessibilityProperties != undefined) this.accessibilityProperties = c.accessibilityProperties;
			if(c.alpha != undefined) this.alpha = c.alpha;
			if(c.blendMode != undefined) this.blendMode = c.blendMode;
			if(c.cacheAsBitmap != undefined) this.cacheAsBitmap = c.cacheAsBitmap;
			if(c.filters != undefined) this.filters = c.filters;
			if(c.height != undefined) this.height = c.height;
			if(c.mask != undefined) this.mask = c.mask;
			if(c.name != undefined) this.name = c.name;
			if(c.opaqueBackground != undefined) this.opaqueBackground = c.opaqueBackground;
			if(c.rotation != undefined) this.rotation = c.rotation;
			if(c.scale9Grid != undefined) this.scale9Grid = c.scale9Grid;
			if(c.scaleX != undefined) this.scaleX = c.scaleX;
			if(c.scaleY != undefined) this.scaleY = c.scaleY;
			if(c.scrollRect != undefined) this.scrollRect = c.scrollRect;
			if(c.transform != undefined) this.transform = c.transform;
			if(c.visible != undefined) this.visible = c.visible;
			if(c.width != undefined) this.width = c.width;
			if(c.x != undefined) this.x = c.x;
			if(c.y != undefined) this.y = c.y;
		}
	}
}

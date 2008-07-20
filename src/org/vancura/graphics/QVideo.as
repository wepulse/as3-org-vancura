package org.vancura.graphics {
	import flash.media.*;

	
	
	/*
	Class: QVideo
	 *Quick creation of Video with initial data.*

	Author: Vaclav Vancura <http://vaclav.vancura.org>

	Since: 22.03.2008
	 */
	public class QVideo extends Video {

		
		
		public function QVideo(c:Object = null) {
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			try {
				super(c.width, c.height);
			}
			catch(err:Error) {
				if(c.width == undefined) throw new Error('Video width undefined');
				if(c.height == undefined) throw new Error('Video height undefined');
			}

			// Sprite overrides and custom settings:
			this.deblocking = (c.deblocking != undefined) ? c.deblocking : 5;
			this.smoothing = (c.smoothing != undefined) ? c.smoothing : true;

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

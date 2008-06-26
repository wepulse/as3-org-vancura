package org.vancura.graphics {



	import flash.display.*;



	/*
		Class: QSprite
		*Quick creation of Sprite with initial data.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 21.03.2008
	*/
	public class QSprite extends Sprite {



		private var __embeddedSpr:Sprite;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function QSprite( c:Object = null ) {
			// if config is not defined, prepare it
			if( c == null ) c = new Object();

			super();

			// Sprite overrides and custom settings:
			if( c.embed != undefined ) {
				if( !( c.embed is Sprite ) ) throw new Error( 'Invalid embed object' );
				__embeddedSpr = c.embed;
				addChild( __embeddedSpr );
			}

			// Sprite overrides:
			if( c.buttonMode != undefined ) this.buttonMode = c.buttonMode;
			if( c.hitArea != undefined ) this.hitArea = c.hitArea;
			if( c.soundTransform != undefined ) this.soundTransform = c.soundTransform;
			if( c.useHandCursor != undefined ) this.useHandCursor = c.useHandCursor;

			// DisplayObjectContainer overrides:
			if( c.mouseChildren != undefined ) this.mouseChildren = c.mouseChildren;
			if( c.tabChildren != undefined ) this.tabChildren = c.tabChildren;

			// InteractiveObject overrides:
			if( c.contextMenu != undefined ) this.contextMenu = c.contextMenu;
			if( c.doubleClickEnabled != undefined ) this.doubleClickEnabled = c.doubleClickEnabled;
			if( c.focusRect != undefined ) this.focusRect = c.focusRect;
			if( c.mouseEnabled != undefined ) this.mouseEnabled = c.mouseEnabled;
			if( c.tabEnabled != undefined ) this.tabEnabled = c.tabEnabled;
			if( c.tabIndex != undefined ) this.tabIndex = c.tabIndex;

			// DisplayObject overrides:
			if( c.accessibilityProperties != undefined ) this.accessibilityProperties = c.accessibilityProperties;
			if( c.alpha != undefined ) this.alpha = c.alpha;
			if( c.blendMode != undefined ) this.blendMode = c.blendMode;
			if( c.cacheAsBitmap != undefined ) this.cacheAsBitmap = c.cacheAsBitmap;
			if( c.filters != undefined ) this.filters = c.filters;
			if( c.height != undefined ) this.height = c.height;
			if( c.mask != undefined ) this.mask = c.mask;
			if( c.name != undefined ) this.name = c.name;
			if( c.opaqueBackground != undefined ) this.opaqueBackground = c.opaqueBackground;
			if( c.rotation != undefined ) this.rotation = c.rotation;
			if( c.scale9Grid != undefined ) this.scale9Grid = c.scale9Grid;
			if( c.scaleX != undefined ) this.scaleX = c.scaleX;
			if( c.scaleY != undefined ) this.scaleY = c.scaleY;
			if( c.scrollRect != undefined ) this.scrollRect = c.scrollRect;
			if( c.transform != undefined ) this.transform = c.transform;
			if( c.visible != undefined ) this.visible = c.visible;
			if( c.width != undefined ) this.width = c.width;
			if( c.x != undefined ) this.x = c.x;
			if( c.y != undefined ) this.y = c.y;
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		public function get embeddedSpr():Sprite {
			return __embeddedSpr;
		}



	}



}

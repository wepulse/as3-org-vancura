package org.vancura.controls {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	import org.vancura.graphics.Bitmapping;
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QBitmap;
	import org.vancura.graphics.QSprite;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;	

	
	
	/**
	 * Toolbar control.
	 * 
	 * TODO: Write documentation
	 * TODO: Clean
	 * TODO: More advanced error handling
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Toolbar extends MorphSprite {

		
		
		public static var defWidth:Number = DefaultControlSettings.DEF_WIDTH;
		public static var defHeight:Number = DefaultControlSettings.DEF_HEIGHT;
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defIconPadding:Number = DefaultControlSettings.DEF_TOOLBAR_ICON_PADDING;
		public static var defPaddingH:Number = DefaultControlSettings.DEF_TOOLBAR_PADDING_H;
		public static var defPaddingV:Number = DefaultControlSettings.DEF_TOOLBAR_PADDING_V;
		public static var defChildSpacing:Number = DefaultControlSettings.DEF_TOOLBAR_CHILD_SPACING;
		public static var defSkin:BitmapData = null;
		protected var $backSBM:ScaleBitmap;
		protected var $canvasSpr:QSprite;
		protected var $iconBM:QBitmap;
		protected var $childSpacing:Number;
		protected var $iconPadding:Number;
		protected var $isIconEnabled:Boolean;
		protected var $paddingH:Number;
		protected var $paddingV:Number;

		
		
		public function Toolbar(c:Object = null) {
			super();

			var bd:BitmapData;
			var iw:Number;

			// convert template data to BitmapData
			if(c && c.skin) bd = Bitmapping.embed2BD(c.skin);
			else {
				// skin parameter is not defined, try to get it from default settings
				if(defSkin == null) throw new TypeError('Toolbar skin is not defined.');
				else bd = defSkin;
				if(c == null) c = new Object();
			}

			// check for right size and textformat
			// and get back size
			if(bd.width % 2 != 0) throw new Error('Width of toolbar skin has to be multiple of two.');
			iw = bd.width / 2;

			// set initial values
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$paddingH = (c.paddingH != undefined) ? c.paddingH : defPaddingH;
			$paddingV = (c.paddingV != undefined) ? c.paddingV : defPaddingV;
			$iconPadding = (c.iconPadding != undefined) ? c.iconPadding : defIconPadding;
			$childSpacing = (c.childSpacing != undefined) ? c.childSpacing : defChildSpacing;

			// add graphics
			var sbm:BitmapData = Bitmapping.crop(bd, 0, 0, iw, bd.height);
			$backSBM = new ScaleBitmap(Bitmapping.crop(bd, iw, 0, iw, bd.height));
			$canvasSpr = new QSprite({x:$paddingH, y:$paddingV});
			$backSBM.scale9Grid = sbm.getColorBoundsRect(sbm.getPixel32(iw / 2, Math.round(bd.height / 2)), 0, false);
			$iconBM = new QBitmap({x:$paddingH});

			// add to display list
			addChildren(this, $backSBM, $iconBM, $canvasSpr);
			
			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.icon = (c.icon != undefined) ? c.icon : null;
			this.width = (c.width != undefined) ? c.width : defWidth;
			this.height = (c.height != undefined) ? c.height : defHeight;
			this.cacheAsBitmap = true;
			this.mask = (c.mask != undefined) ? c.mask : null;
		}

		
		
		public function destroy():void {
			// remove from display list
			removeChildren(this, $backSBM, $iconBM, $canvasSpr);

			// remove icon
			if($isIconEnabled) _disposeIcon();
		}

		
		
		public function autoSize():void {
			width = $canvasSpr.width + $paddingH * 2 + (($isIconEnabled) ? ($iconPadding + $iconBM.width) : 0);
			height = $canvasSpr.height + $paddingV * 2;
		}

		
		
		public function addChildRight(value:DisplayObject):void {
			value.x = ($canvasSpr.width == 0) ? 0 : $canvasSpr.width + $childSpacing;
			$canvasSpr.addChild(value);
			autoSize();
		}

		
		
		public function set icon(value:*):void {
			var bd:BitmapData;

			_disposeIcon();

			if(value) {
				if(value is Bitmap) bd = value.bitmapData;
				else if(value is BitmapData) bd = value;
				else throw new Error('Invalid embed object');

				$iconBM.bitmapData = bd;
				$isIconEnabled = true;

				$canvasSpr.x = $paddingH + $iconBM.width + $iconPadding;
			}
		}

		
		
		override public function set width(value:Number):void {
			$backSBM.width = value;
		}

		
		
		override public function set height(value:Number):void {
			$backSBM.height = value;
			$iconBM.y = Math.round((value - $iconBM.height) / 2);
		}

		
		
		public function get canvas():Sprite {
			return $canvasSpr;
		}

		
		
		private function _disposeIcon():void {
			if($isIconEnabled) {
				$iconBM.bitmapData.dispose();
				$isIconEnabled = false;
				$canvasSpr.x = $paddingH;
			}
		}
	}
}

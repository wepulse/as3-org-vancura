package org.vancura.controls {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.vancura.graphics.Bitmapping;
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QSprite;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;
	
	import de.popforge.utils.sprintf;
	
	import caurina.transitions.Tweener;	

	
	
	/**
	 * VUMeter control.
	 * 
	 * TODO: Write documentation
	 * TODO: More advanced error handling
	 * TODO: Clean
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class VUMeter extends MorphSprite {

		
		
		public static const SET_1:String = 'set1';
		public static const SET_2:String = 'set2';
		public static const TEMPLATE_LEDS:uint = 12;
		public static const DIRECTION_HORIZONTAL:String = 'directionHorizontal';
		public static const DIRECTION_VERTICAL:String = 'directionVertical';
		public static var defLeds:Number = DefaultControlSettings.DEF_VUMETER_LEDS;
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defSpacingH:Number = DefaultControlSettings.DEF_VUMETER_SPACING_H;
		public static var defSpacingV:Number = DefaultControlSettings.DEF_VUMETER_SPACING_V;
		public static var defSkin:BitmapData = null;
		protected var $ledSet1Spr:QSprite;
		protected var $ledSet2Spr:QSprite;
		protected var $leds:uint;
		protected var $templateHeight:Number;
		protected var $templateWidth:Number;
		protected var $templateList:Array = new Array();
		protected var $ledSet1List:Array = new Array();
		protected var $ledSet2List:Array = new Array();
		protected var $dir:String;
		protected var $spacingH:Number;
		protected var $spacingV:Number;

		
		
		public function VUMeter(c:Object = null, d:String = DIRECTION_HORIZONTAL) {
			super();

			// init vars
			var bd:BitmapData;

			// check for direction
			if(d != DIRECTION_HORIZONTAL && d != DIRECTION_VERTICAL) throw new TypeError('VUMeter type has to be DIRECTION_HORIZONTAL or DIRECTION_VERTICAL.');
			else $dir = d;

			// convert template data to BitmapData
			if(c && c.skin) bd = Bitmapping.embed2BD(c.skin);
			else {
				// skin parameter is not defined, try to get it from default settings
				if(defSkin == null) throw new Error('VUMeter skin is not defined.');
				else bd = defSkin;
				if(c == null) c = new Object();
			}

			// check for right size and textformat
			// and get item size
			if(bd.width % TEMPLATE_LEDS != 0) throw new Error('Width of VUMeter skin has to be multiple of %d.');

			// get item size
			$templateWidth = bd.width / TEMPLATE_LEDS;
			$templateHeight = bd.height;

			// create led template
			for(var i:uint = 0;i < TEMPLATE_LEDS; i++) $templateList.push(Bitmapping.crop(bd, i * $templateWidth, 0, $templateWidth, $templateHeight));

			// set initial values
			$leds = (c.leds != undefined) ? c.leds : defLeds;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$isChangeWidthEnabled = false;
			$isChangeHeightEnabled = false;
			$isMorphWidthEnabled = false;
			$isMorphHeightEnabled = false;

			// add set sprites
			$ledSet1Spr = new QSprite();
			$ledSet2Spr = new QSprite();

			// set initial values
			$spacingH = (c.spacingH != undefined) ? c.spacingH : defSpacingH;
			$spacingV = (c.spacingV != undefined) ? c.spacingV : defSpacingV;

			// fill rows
			_fillSet($ledSet1Spr, $ledSet1List);
			_fillSet($ledSet2Spr, $ledSet2List);

			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.mask = (c.mask != undefined) ? c.mask : null;

			if($dir == DIRECTION_HORIZONTAL) $ledSet2Spr.y = $templateHeight + $spacingV;
			else $ledSet2Spr.x = $spacingH;

			// blink all leds
			intro();

			// add to display list
			addChildren(this, $ledSet1Spr, $ledSet2Spr);
		}

		
		
		public function destroy():void {
			// remove leds
			for(var i:uint = 0;i < $leds; i++) {
				$ledSet1Spr.removeChild($ledSet1List[i]);
				$ledSet2Spr.removeChild($ledSet2List[i]);
			}

			// remove from display list
			removeChildren(this, $ledSet1Spr, $ledSet2Spr);
		}

		
		
		public function intro():void {
			for(var i:int = 0;i < $leds; i++) {
				var o:Object = new Object();
				o.id = i;
				Tweener.addTween(o, {delay:1 + i * .02, onComplete:function():void {
					blinkLed(SET_1, this.id);
					blinkLed(SET_2, this.id);
				}});
			}
		}

		
		
		public function blinkLed(setID:String, idx:uint):void {
			var r:Array;

			if(setID == SET_1) r = $ledSet1List;
			else if(setID == SET_2) r = $ledSet2List;
			else throw new Error(sprintf('Invalid set ID (%s)', setID));

			if(idx < 0 || idx > $leds) throw new Error(sprintf('Invalid led index (%d)', idx));

			r[idx].visible = true;
			Tweener.addTween(r[idx], {time:.5, alpha:0, transition:'linear', onComplete:function():void {
				this.visible = false;
				this.alpha = 1;
			}});
		}

		
		
		protected function $mark(setID:Array, idx:uint):void {
			for(var i:uint = 0;i < $leds; i++) setID[i].visible = (i <= idx);
		}

		
		
		protected function $getLedIdx(level:Number):int {
			var l:int = Math.round($leds / (100 / level));
			if(l >= $leds) l = $leds - 1;
			if(l < 0) l = 0;
			return l;
		}

		
		
		public function set leftLevel(value:Number):void {
			$mark($ledSet1List, $getLedIdx(value));
		}

		
		
		public function set rightLevel(value:Number):void {
			$mark($ledSet2List, $getLedIdx(value));
		}

		
		
		public function set bothLevels(value:Number):void {
			var l:int = $getLedIdx(value);
			$mark($ledSet1List, l);
			$mark($ledSet2List, l);
		}

		
		
		private function _fillSet(setSpr:QSprite, setList:Array):void {
			for(var i:uint = 0;i < $leds; i++) {
				// count led idx to choose from template
				var j:int = (TEMPLATE_LEDS - $leds) + i;
				if(j < 1) j = 1;

				// create new bitmaps
				var bmF:Bitmap = new Bitmap($templateList[0]);
				var bmO:Bitmap = new Bitmap($templateList[j]);

				// add to display list
				if($dir == DIRECTION_HORIZONTAL) {
					if(i > 0) bmF.x = bmO.x = i * ($templateWidth + $spacingH);
				}
				else {
					var my:Number = ($leds * ($templateHeight + $spacingV)) - ((i + 1) * ($templateHeight + $spacingV));
					bmF.y = bmO.y = my;
				}
				bmO.visible = false;
				setSpr.addChild(bmF);
				setSpr.addChild(bmO);

				// add to set list
				setList.push(bmO);
			}
		}
	}
}

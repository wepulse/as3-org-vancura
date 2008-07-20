package org.vancura.controls {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QSprite;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;	

	
	
	/**
	 * Knob control.
	 * 
	 * TODO: Write documentation
	 * TODO: Knob functionality
	 * TODO: More advanced error handling
	 * TODO: Clean
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Knob extends MorphSprite {

		
		
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defBackSkin:BitmapData = null;
		public static var defPointerSpr:Sprite = null;
		public static var defOverInTime:Number = DefaultControlSettings.DEF_OVER_IN_TIME;
		public static var defOverOutTime:Number = DefaultControlSettings.DEF_OVER_OUT_TIME;
		public static var defPressInTime:Number = DefaultControlSettings.DEF_PRESS_IN_TIME;
		public static var defPressOutTime:Number = DefaultControlSettings.DEF_PRESS_OUT_TIME;
		protected var $backBtn:Button;
		protected var $pointerSpr:QSprite;
		protected var $overInTime:Number;
		protected var $overOutTime:Number;
		protected var $pressInTime:Number;
		protected var $pressOutTime:Number;
		private var _areEventsEnabled:Boolean = true;

		
		
		public function Knob(c:Object = null) {
			super();

			if(c == null) c = new Object();
			if(c.pointerSpr == undefined && defPointerSpr == null) throw new Error('Default knob pointer is not defined.');

			// get some data
			$overInTime = (c.overInTime != undefined) ? c.overInTime : defOverInTime;
			$overOutTime = (c.overOutTime != undefined) ? c.overOutTime : defOverOutTime;
			$pressInTime = (c.pressInTime != undefined) ? c.pressInTime : defPressInTime;
			$pressOutTime = (c.pressOutTime != undefined) ? c.pressOutTime : defPressOutTime;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			
			// construct back data
			var backData:Object = {
				$overInTime:$overInTime, $overOutTime:$overOutTime, $pressInTime:$pressInTime, $pressOutTime:$pressOutTime, morphTime:(c.morphTime != undefined) ? c.morphTime : defMorphTime, skin:(c.backSkin != undefined) ? c.backSkin : defBackSkin
			};
			
			// add back button
			$backBtn = new Button(backData, Button.TYPE_NOSCALE_BUTTON);

			// construct pointer data
			var pointerData:Object = {
				embed:(c.pointerSpr != undefined) ? c.pointerSpr : defPointerSpr, x:$backBtn.width / 2, y:$backBtn.height / 2, mouseEnabled:false
			};

			// add pointer sprite
			$pointerSpr = new QSprite(pointerData);

			// noscale button mode
			$isChangeWidthEnabled = false;
			$isChangeHeightEnabled = false;
			$isMorphWidthEnabled = false;
			$isMorphHeightEnabled = false;

			// add to display list
			addChildren(this, $backBtn, $pointerSpr);
			
			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.mask = (c.mask != undefined) ? c.mask : null;
		}

		
		
		public function destroy():void {
			// remove from display list
			removeChildren(this, $backBtn, $pointerSpr);

			// destroy subcontrols
			$backBtn.destroy();
		}
		
		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}
		
		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			$backBtn.areEventsEnabled = value;
		}
	}
}

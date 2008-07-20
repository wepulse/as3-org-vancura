package org.vancura.controls {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.bytearray.display.ScaleBitmap;
	import org.vancura.graphics.Bitmapping;
	import org.vancura.graphics.Drawing;
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QSprite;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;
	
	import caurina.transitions.Tweener;	

	
	
	/**
	 * Slider control.
	 * 
	 * TODO: Write documentation
	 * TODO: More advanced error handling
	 * TODO: Clean
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Slider extends MorphSprite {

		
		
		public static const DIRECTION_HORIZONTAL:String = 'directionHorizontal';
		public static const DIRECTION_VERTICAL:String = 'directionVertical';
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defBackSkin:BitmapData = null;
		public static var defThumbSkin:BitmapData = null;
		public static var defOverInTime:Number = DefaultControlSettings.DEF_OVER_IN_TIME;
		public static var defOverOutTime:Number = DefaultControlSettings.DEF_OVER_OUT_TIME;
		public static var defPressInTime:Number = DefaultControlSettings.DEF_PRESS_IN_TIME;
		public static var defPressOutTime:Number = DefaultControlSettings.DEF_PRESS_OUT_TIME;
		public static var defSlideTime:Number = DefaultControlSettings.DEF_SLIDER_SLIDE_TIME;
		public static var defReleaseTime:Number = DefaultControlSettings.DEF_SLIDER_RELEASE_TIME;
		public static var defWheelRatio:Number = DefaultControlSettings.DEF_SLIDER_WHEEL_RATIO;
		protected var $backSBM:ScaleBitmap;
		protected var $thumbBtn:Button;
		protected var $trackSpr:QSprite;
		protected var $marginBegin:int;
		protected var $marginEnd:int;
		protected var $dir:String;
		protected var $slideTime:Number;
		protected var $releaseTime:Number;
		protected var $wheelRatio:Number;
		protected var $rangePx:int;
		protected var $currentThumbPos:Number;
		protected var $isDraggingEnabled:Boolean;
		protected var $dragOffs:Number;
		protected var $thumbOffs:Number;
		protected var $baseWidth:Number;
		protected var $baseHeight:Number;
		protected var $overInTime:Number;
		protected var $overOutTime:Number;
		protected var $pressInTime:Number;
		protected var $pressOutTime:Number;
		private var _areEventsEnabled:Boolean = true;

		
		
		public function Slider(c:Object = null, d:String = DIRECTION_HORIZONTAL) {
			super();

			// init vars
			var bd:BitmapData;
			var ih:Number;

			// check for direction
			if(d != DIRECTION_HORIZONTAL && d != DIRECTION_VERTICAL) throw new TypeError('Slider type has to be DIRECTION_HORIZONTAL or DIRECTION_VERTICAL.');
			else $dir = d;
			
			// get some data
			$overInTime = (c.overInTime != undefined) ? c.overInTime : defOverInTime;
			$overOutTime = (c.overOutTime != undefined) ? c.overOutTime : defOverOutTime;
			$pressInTime = (c.pressInTime != undefined) ? c.pressInTime : defPressInTime;
			$pressOutTime = (c.pressOutTime != undefined) ? c.pressOutTime : defPressOutTime;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			
			// get thumb default data,
			var thumbData:Object = {
				$overInTime:$overInTime, $overOutTime:$overOutTime, $pressInTime:$pressInTime, $pressOutTime:$pressOutTime, morphTime:(c.morphTime != undefined) ? c.morphTime : defMorphTime, skin:(c.thumbSkin != undefined) ? c.thumbSkin : defThumbSkin
			};

			// convert back skin definitions to BitmapData
			if(c && c.backSkin) bd = Bitmapping.embed2BD(c.backSkin);
			else {
				// back skin parameter is not defined, try to get it from default settings
				if(defBackSkin == null) throw new Error('Slider back skin not defined.');
				else bd = defBackSkin;
				if(c == null) c = new Object();
			}

			// convert thumb skin definitions to BitmapData
			if(c && c.thumbSkin) thumbData.skin = Bitmapping.embed2BD(c.thumbSkin);
			else {
				// thumb skin parameter is not defined, try to get it from default settings
				if(defThumbSkin == null) throw new Error('Slider thumb skin is not defined.');
				if(c == null) c = new Object();
			}

			// check for right size
			// and get item size
			if(bd.height % 2 != 0) throw new Error('Height of slider back skin has to be multiple of two.');
			ih = bd.height / 2;

			// set initial values
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$slideTime = (c.slideTime != undefined) ? c.slideTime : defSlideTime;
			$releaseTime = (c.releaseTime != undefined) ? c.releaseTime : defReleaseTime;
			$wheelRatio = (c.wheelRatio != undefined) ? c.wheelRatio : defWheelRatio;

			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.$marginBegin = (c.marginBegin != undefined) ? c.marginBegin : 0;
			this.$marginEnd = (c.marginEnd != undefined) ? c.marginEnd : 0;

			// set direction flags
			if($dir == DIRECTION_HORIZONTAL) {
				$baseWidth = (c.width != undefined) ? c.width : bd.width;
				$baseHeight = ih;
				$isChangeHeightEnabled = false;
				$isMorphHeightEnabled = false;
			}
			else {
				$baseWidth = bd.width;
				$baseHeight = (c.height != undefined) ? c.height : ih;
				$isChangeWidthEnabled = false;
				$isMorphWidthEnabled = false;
			}

			// add back, track and thumb
			var sbm:BitmapData = Bitmapping.crop(bd, 0, 0, bd.width, ih);
			$backSBM = new ScaleBitmap(Bitmapping.crop(bd, 0, ih, bd.width, ih));
			$backSBM.scale9Grid = sbm.getColorBoundsRect(sbm.getPixel32(Math.round(bd.width / 2), ih / 2), 0, false);
			$trackSpr = new QSprite({alpha:0});
			$thumbBtn = new Button(thumbData, Button.TYPE_NOSCALE_BUTTON);

			// get offsets
			$thumbOffs = Math.round((($dir == DIRECTION_HORIZONTAL) ? $thumbBtn.width : $thumbBtn.height) * -.5);
			$dragOffs = $thumbOffs * -1;

			// change size
			this.width = $baseWidth;
			this.height = $baseHeight;

			// reset thumb
			resetThumb();
			
			// add to display list
			addChildren(this, $backSBM, $trackSpr, $thumbBtn);

			// add event listeners
			$trackSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMove, false, 0, true);
			$trackSpr.addEventListener(MouseEvent.MOUSE_WHEEL, _onWheel, false, 0, true);
			$thumbBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbPress, false, 0, true);
			$thumbBtn.addEventListener(MouseEvent.MOUSE_UP, _onThumbRelease, false, 0, true);
			$thumbBtn.addEventListener(MouseEvent.MOUSE_WHEEL, _onWheel, false, 0, true);
			$thumbBtn.addEventListener(ButtonEvent.RELEASE_OUTSIDE, _onThumbRelease, false, 0, true);
		}

		
		
		public function destroy():void {
			// remove from display list
			removeChildren(this, $backSBM, $trackSpr, $thumbBtn);

			// remove event listeners
			$trackSpr.removeEventListener(MouseEvent.MOUSE_DOWN, _onThumbMove);
			$trackSpr.removeEventListener(MouseEvent.MOUSE_WHEEL, _onWheel);
			$thumbBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onThumbPress);
			$thumbBtn.removeEventListener(MouseEvent.MOUSE_UP, _onThumbRelease);
			$thumbBtn.removeEventListener(MouseEvent.MOUSE_WHEEL, _onWheel);
			$thumbBtn.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, _onThumbRelease);

			// destroy sub controls
			$thumbBtn.destroy();
		}

		
		
		public function resetThumb():void {
			$currentThumbPos = 0;
			_recountRange();
			_refreshTrack();
			refreshThumb();
		}

		
		
		public function refreshThumb():void {
			if($currentThumbPos < 0) $currentThumbPos = 0;
			if($currentThumbPos > 1) $currentThumbPos = 1;
			var px:int = $marginBegin + Math.round($currentThumbPos * $rangePx);

			var t:Object = new Object();
			t.time = $slideTime;
			t.rounded = true;

			if($dir == DIRECTION_HORIZONTAL) t.x = px + $thumbOffs;
			else t.y = px + $thumbOffs;

			Tweener.removeTweens($thumbBtn);
			Tweener.addTween($thumbBtn, t);
			
			dispatchEvent(new SliderEvent(SliderEvent.REFRESH, true, false, $currentThumbPos));
		}

		
		
		override public function set width(value:Number):void {
			if($dir == DIRECTION_HORIZONTAL) $backSBM.width = value;
			$baseWidth = value;
			_recountRange();
			_refreshTrack();
			refreshThumb();
		}

		
		
		override public function set height(value:Number):void {
			if($dir == DIRECTION_VERTICAL) $backSBM.height = value;
			$baseHeight = value;
			_recountRange();
			_refreshTrack();
			refreshThumb();
		}

		
		
		override public function get width():Number {
			return $baseWidth;
		}

		
		
		override public function get height():Number {
			return $baseHeight;
		}

		
		
		public function set thumbPos(value:Number):void {
			$currentThumbPos = value;
			refreshThumb();
		}

		
		
		public function get thumbPos():Number {
			return $currentThumbPos;
		}

		
		
		private function _recountRange():void {
			if($dir == DIRECTION_HORIZONTAL) $rangePx = this.width - $marginEnd - $marginBegin;
			else $rangePx = this.height - $marginEnd - $marginBegin;
		}

		
		
		private function _px2pos(value:Number):Number {
			var p:Number = 1 / ($rangePx / (value - $marginBegin - $dragOffs - $thumbOffs));
			if(p < 0) p = 0;
			if(p > 1) p = 1;
			return p;
		}

		
		
		private function _refreshTrack():void {
			if($trackSpr) {
				$trackSpr.graphics.clear();
				if($dir == DIRECTION_HORIZONTAL) Drawing.drawRect($trackSpr, $marginBegin, 0, $rangePx, $baseHeight);
				else Drawing.drawRect($trackSpr, 0, $marginBegin, $baseWidth, $rangePx);
			}
		}

		
		
		private function _onThumbPress(event:MouseEvent):void {
			if(!_areEventsEnabled) return; // events are not enabled
			
			$isDraggingEnabled = true;
			$dragOffs = ($dir == DIRECTION_HORIZONTAL) ? event.currentTarget.mouseX : event.currentTarget.mouseY;

			Tweener.removeTweens($thumbBtn);
			$thumbBtn.alpha = .2;
			$thumbBtn.cacheAsBitmap = true;

			addEventListener(Event.ENTER_FRAME, _onThumbMove, false, 0, true);
		}

		
		
		private function _onThumbRelease(event:Event):void {
			if(!_areEventsEnabled) return; // events are not enabled
			
			$isDraggingEnabled = false;
			$dragOffs = $thumbOffs * -1;

			Tweener.addTween($thumbBtn, {alpha:1, time:$releaseTime, transition:'easeOutSine', onComplete:function():void {
				$thumbBtn.cacheAsBitmap = false;
			}});

			removeEventListener(Event.ENTER_FRAME, _onThumbMove);
		}

		
		
		private function _onThumbMove(event:Event):void {
			if(!_areEventsEnabled) return; // events are not enabled
			
			if($dir == DIRECTION_HORIZONTAL) thumbPos = _px2pos(event.target.mouseX);
			else thumbPos = _px2pos(event.target.mouseY);
		}

		
		
		private function _onWheel(event:MouseEvent):void {
			if(!_areEventsEnabled) return; // events are not enabled
			
			thumbPos += event.delta * $wheelRatio * (($dir == DIRECTION_VERTICAL) ? -1 : 1);
		}
		
		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}
		
		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			$thumbBtn.areEventsEnabled = value;
		}
	}
}

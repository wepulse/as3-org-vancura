package org.vancura.controls {
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.bytearray.display.ScaleBitmap;
	import org.vancura.graphics.Bitmapping;
	import org.vancura.graphics.Drawing;
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QBitmap;
	import org.vancura.graphics.QSprite;
	import org.vancura.graphics.QTextField;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;
	
	import caurina.transitions.Tweener;		

	
	
	/**
	 * Button control.
	 * 
	 * TODO: Write documentation
	 * TODO: Buttons with no text but just icon are horizontaly misaligned
	 * TODO: Check for memory leaks (bitmap disposal needed?)
	 * TODO: Try to optimize
	 * TODO: More advanced error handling
	 * TODO: Clean
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Button extends MorphSprite {

		
		
		public static const TYPE_SCALE_BUTTON:String = 'typeScaleButton';
		public static const TYPE_NOSCALE_BUTTON:String = 'typeNoScaleButton';
		public static var defWidth:Number = DefaultControlSettings.DEF_WIDTH;
		public static var defHeight:Number = DefaultControlSettings.DEF_HEIGHT;
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defIconPadding:Number = DefaultControlSettings.DEF_BUTTON_ICON_PADDING;
		public static var defSkin:BitmapData = null;
		public static var defOverInTime:Number = DefaultControlSettings.DEF_OVER_IN_TIME;
		public static var defOverOutTime:Number = DefaultControlSettings.DEF_OVER_OUT_TIME;
		public static var defPressInTime:Number = DefaultControlSettings.DEF_PRESS_IN_TIME;
		public static var defPressOutTime:Number = DefaultControlSettings.DEF_PRESS_OUT_TIME;
		public static var defTextOutAlpha:Number = DefaultControlSettings.DEF_TEXT_OUT_ALPHA;
		public static var defTextOutFilters:Array = DefaultControlSettings.DEF_TEXT_OUT_FILTERS;
		public static var defTextOutFormat:TextFormat = DefaultControlSettings.DEF_TEXT_OUT_FORMAT;
		public static var defTextOutOffsY:Number = DefaultControlSettings.DEF_TEXT_OUT_OFFS_Y;
		public static var defTextOverAlpha:Number = DefaultControlSettings.DEF_TEXT_OVER_ALPHA;
		public static var defTextOverFilters:Array = DefaultControlSettings.DEF_TEXT_OVER_FILTERS;
		public static var defTextOverFormat:TextFormat = DefaultControlSettings.DEF_TEXT_OVER_FORMAT;
		public static var defTextOverOffsY:Number = DefaultControlSettings.DEF_TEXT_OVER_OFFS_Y;
		public static var defTextPressAlpha:Number = DefaultControlSettings.DEF_TEXT_PRESS_ALPHA;
		public static var defTextPressFilters:Array = DefaultControlSettings.DEF_TEXT_PRESS_FILTERS;
		public static var defTextPressFormat:TextFormat = DefaultControlSettings.DEF_TEXT_PRESS_FORMAT;
		public static var defTextPressOffsY:Number = DefaultControlSettings.DEF_TEXT_PRESS_OFFS_Y;
		protected var $iconOutBM:QBitmap;
		protected var $iconOverBM:QBitmap;
		protected var $iconPressBM:QBitmap;
		protected var $itemActiveSpr:QSprite;
		protected var $itemOutSBM:ScaleBitmap;
		protected var $itemOverSBM:ScaleBitmap;
		protected var $itemPressSBM:ScaleBitmap;
		protected var $textOutTextField:QTextField;
		protected var $textOverTextField:QTextField;
		protected var $textPressTextField:QTextField;
		protected var $iconPadding:Number;
		protected var $isIconEnabled:Boolean;
		protected var $isTextEnabled:Boolean;
		protected var $itemWidth:Number;
		protected var $itemHeight:Number;
		protected var $textOutAlpha:Number;
		protected var $textOutOffsY:Number;
		protected var $textOverAlpha:Number;
		protected var $textOverOffsY:Number;
		protected var $textPressAlpha:Number;
		protected var $textPressOffsY:Number;
		protected var $overInTime:Number;
		protected var $overOutTime:Number;
		protected var $pressInTime:Number;
		protected var $pressOutTime:Number;
		protected var $type:String;
		private static var _currentDraggingButton:Button;
		private var _areEventsEnabled:Boolean = true;

		
		
		/**
		 * Button constructor.
		 * @param c Config data
		 * @param t Button type (TYPE_SCALE_BUTTON or TYPE_NOSCALE_BUTTON, if not specified, TYPE_SCALE_BUTTON used instead)
		 */
		public function Button(c:Object = null, t:String = TYPE_SCALE_BUTTON) {
			super();

			var bd:BitmapData;

			// check for type
			if(t != TYPE_NOSCALE_BUTTON && t != TYPE_SCALE_BUTTON) throw new TypeError('Button type has to be TYPE_NOSCALE_BUTTON or TYPE_SCALE_BUTTON.');
			else $type = t;

			// convert template data to BitmapData
			if(c && c.skin) bd = Bitmapping.embed2BD(c.skin);
			else {
				// skin parameter is not defined, try to get it from default settings
				if(defSkin == null) throw new Error('Button default skin is not defined.');
				else bd = defSkin;
				if(c == null) c = new Object();
			}

			// check for right size and textformat
			if(bd.width % 2 != 0) throw new Error('Width of button skin has to be multiple of two.');
			if(bd.height % 2 != 0) throw new Error('Height of button skin has to be multiple of two.');
			if(defTextOutFormat == null || defTextOverFormat == null || defTextPressFormat == null) throw new Error('Default button text formats are not defined.');

			// get item size
			$itemWidth = bd.width / 2;
			$itemHeight = bd.height / 2;

			// set initial values
			$overInTime = (c.overInTime != undefined) ? c.overInTime : defOverInTime;
			$overOutTime = (c.overOutTime != undefined) ? c.overOutTime : defOverOutTime;
			$pressInTime = (c.pressInTime != undefined) ? c.pressInTime : defPressInTime;
			$pressOutTime = (c.pressOutTime != undefined) ? c.pressOutTime : defPressOutTime;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$iconPadding = (c.iconPadding != undefined) ? c.iconPadding : defIconPadding;
			$textOutAlpha = (c.textOutAlpha != undefined) ? c.textOutAlpha : defTextOutAlpha;
			$textOutOffsY = (c.textOutOffsY != undefined) ? c.textOutOffsY : defTextOutOffsY;
			$textOverAlpha = (c.textOverAlpha != undefined) ? c.textOverAlpha : defTextOverAlpha;
			$textOverOffsY = (c.textOverOffsY != undefined) ? c.textOverOffsY : defTextOverOffsY;
			$textPressAlpha = (c.textPressAlpha != undefined) ? c.textPressAlpha : defTextPressAlpha;
			$textPressOffsY = (c.textPressOffsY != undefined) ? c.textPressOffsY : defTextPressOffsY;

			// get item images
			var sbm:BitmapData = Bitmapping.crop(bd, 0, 0, $itemWidth, $itemHeight);
			$itemOutSBM = new ScaleBitmap(Bitmapping.crop(bd, $itemWidth, 0, $itemWidth, $itemHeight));
			$itemOverSBM = new ScaleBitmap(Bitmapping.crop(bd, 0, $itemHeight, $itemWidth, $itemHeight));
			$itemPressSBM = new ScaleBitmap(Bitmapping.crop(bd, $itemWidth, $itemHeight, $itemWidth, $itemHeight));
			$itemOutSBM.scale9Grid = $itemOverSBM.scale9Grid = $itemPressSBM.scale9Grid = sbm.getColorBoundsRect(sbm.getPixel32($itemWidth / 2, $itemHeight / 2), 0, false);

			// add graphics
			$textOutTextField = new QTextField({defaultTextFormat:(c.textOutFormat != undefined) ? c.textOutFormat : defTextOutFormat, filters:(c.textOutFilters != undefined) ? c.textOutFilters : defTextOutFilters});
			$textOverTextField = new QTextField({defaultTextFormat:(c.textOverFormat != undefined) ? c.textOverFormat : defTextOverFormat, filters:(c.textOverFilters != undefined) ? c.textOverFilters : defTextOverFilters});
			$textPressTextField = new QTextField({defaultTextFormat:(c.textPressFormat != undefined) ? c.textPressFormat : defTextPressFormat, filters:(c.textPressFilters != undefined) ? c.textPressFilters : defTextPressFilters});
			$iconOutBM = new QBitmap({filters:(c.textOutFilters != undefined) ? c.textOutFilters : defTextOutFilters});
			$iconOverBM = new QBitmap({filters:(c.textOverFilters != undefined) ? c.textOutFilters : defTextOverFilters});
			$iconPressBM = new QBitmap({filters:(c.textPressFilters != undefined) ? c.textOutFilters : defTextPressFilters});
			$itemActiveSpr = new QSprite({alpha:0});
			
			// drawing
			Drawing.drawRect($itemActiveSpr, 0, 0, $itemWidth, $itemHeight);

			// add to display list
			addChildren(this, $itemOutSBM, $itemOverSBM, $itemPressSBM, $textOutTextField, $textOverTextField, $textPressTextField, $iconOutBM, $iconOverBM, $iconPressBM, $itemActiveSpr);

			// add event listeners
			$itemActiveSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			$itemActiveSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			$itemActiveSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onPress, false, 0, true);
			$itemActiveSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);

			// set visual properties
			$iconOutBM.alpha = $textOutAlpha;
			$textOutTextField.alpha = $textOutAlpha;
			$iconOverBM.alpha = 0;
			$iconPressBM.alpha = 0;
			$itemOverSBM.alpha = 0;
			$itemPressSBM.alpha = 0;
			$textOverTextField.alpha = 0;
			$textPressTextField.alpha = 0;
			$itemActiveSpr.buttonMode = true;
			$itemActiveSpr.tabEnabled = false;
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.icon = (c.icon != undefined) ? c.icon : null;
			this.width = (c.width != undefined) ? c.width : defWidth;
			this.height = (c.height != undefined) ? c.height : defHeight;
			this.text = (c.text != undefined) ? c.text : '';
			this.cacheAsBitmap = true;
			this.mask = (c.mask != undefined) ? c.mask : null;
			
			if($type == TYPE_NOSCALE_BUTTON) {
				// noscale button mode
				width = $itemWidth;
				height = $itemHeight;
				$isChangeWidthEnabled = false;
				$isChangeHeightEnabled = false;
				$isMorphWidthEnabled = false;
				$isMorphHeightEnabled = false;
			}
		}

		
		
		public function destroy():void {
			// remove from display list
			removeChildren(this, $itemOutSBM, $itemOverSBM, $itemPressSBM, $textOutTextField, $textOverTextField, $textPressTextField, $iconOutBM, $iconOverBM, $iconPressBM, $itemActiveSpr);

			// remove icon
			if($isIconEnabled) _disposeIcon();

			// remove event listeners
			$itemActiveSpr.removeEventListener(MouseEvent.MOUSE_OVER, _onOver);
			$itemActiveSpr.removeEventListener(MouseEvent.MOUSE_OUT, _onOut);
			$itemActiveSpr.removeEventListener(MouseEvent.MOUSE_DOWN, _onPress);
			$itemActiveSpr.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);
		}

		
		
		public function set icon(value:*):void {
			_disposeIcon();
			if(value) {
				$iconOutBM.bitmapData = $iconOverBM.bitmapData = $iconPressBM.bitmapData = Bitmapping.embed2BD(value);
				$isIconEnabled = true;
			}
			_refreshAlign();
		}

		
		
		public function set text(value:String):void {
			if(value != '') {
				$textOutTextField.text = $textOverTextField.text = $textPressTextField.text = value;
				$isTextEnabled = true;
			}
			else {
				$textOutTextField.text = $textOverTextField.text = $textPressTextField.text = '';
				$isTextEnabled = false;
			}
			_refreshAlign();
		}

		
		
		override public function set width(value:Number):void {
			if($isChangeWidthEnabled) {
				$itemOutSBM.width = value;
				$itemOverSBM.width = value;
				$itemPressSBM.width = value;
				$itemActiveSpr.width = value;
				_refreshAlign();
			}
		}

		
		
		override public function set height(value:Number):void {
			if($isChangeHeightEnabled) {
				$itemOutSBM.height = value;
				$itemOverSBM.height = value;
				$itemPressSBM.height = value;
				$itemActiveSpr.height = value;
				_refreshAlign();
			}
		}

		
		
		override public function get width():Number {
			return $itemActiveSpr.width;
		}

		
		
		override public function get height():Number {
			return $itemActiveSpr.height;
		}

		
		
		public static function get currentDraggingButton():Button {
			return _currentDraggingButton;
		}

		
		
		private function _refreshAlign():void {
			var my:Number = Math.round(height / 2);

			var iconWidth:Number = ($isIconEnabled) ? ($iconOutBM.width + (($isTextEnabled) ? $iconPadding : 0)) : 0;
			$textOutTextField.width = width - 1 - iconWidth;
			$textOverTextField.width = width - 1 - iconWidth;
			$textPressTextField.width = width - 1 - iconWidth;
			$textOutTextField.x = iconWidth;
			$textOverTextField.x = iconWidth;
			$textPressTextField.x = iconWidth;

			var textY:Number = my - Math.round($textOutTextField.textHeight / 2);
			$textOutTextField.y = textY + $textOutOffsY;
			$textOverTextField.y = textY + $textOverOffsY;
			$textPressTextField.y = textY + $textPressOffsY;

			$textOutTextField.height = $textOutTextField.textHeight + 5;
			$textOverTextField.height = $textOverTextField.textHeight + 5;
			$textPressTextField.height = $textPressTextField.textHeight + 5;

			if($isIconEnabled) {
				var iconX:Number = Math.round((width - $textOutTextField.textWidth - iconWidth) / 2);
				var iconY:Number = my - 4;
				$iconOutBM.x = iconX;
				$iconOverBM.x = iconX;
				$iconPressBM.x = iconX;
				$iconOutBM.y = iconY + $textOutOffsY;
				$iconOverBM.y = iconY + $textOverOffsY;
				$iconPressBM.y = iconY + $textPressOffsY;
			}
		}

		
		
		private function _disposeIcon():void {
			if($isIconEnabled) {
				$iconOutBM.bitmapData.dispose();
				$iconOverBM.bitmapData.dispose();
				$iconPressBM.bitmapData.dispose();
				$isIconEnabled = false;
			}
		}

		
		
		private function _onOver(event:MouseEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(event.buttonDown) dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER)); // drag over
			else {
				// roll over
				if($overInTime > 0) {
					cacheAsBitmap = false;
					Tweener.addTween(this, {delay:$overInTime, onComplete:function():void {
						cacheAsBitmap = true; 
					}});
				}

				Tweener.addTween($itemOverSBM, {alpha:1, time:$overInTime, transition:'easeOutSine'});
				Tweener.addTween($textOutTextField, {alpha:0, time:$overInTime, transition:'easeInSine'});
				Tweener.addTween($textOverTextField, {alpha:$textOverAlpha, time:$overInTime, transition:'easeOutSine'});
				Tweener.addTween($textPressTextField, {alpha:0, time:$overInTime, transition:'easeInSine'});

				if($isIconEnabled) {
					Tweener.addTween($iconOutBM, {alpha:0, time:$overInTime, transition:'easeInSine'});
					Tweener.addTween($iconOverBM, {alpha:$textOverAlpha, time:$overInTime, transition:'easeOutSine'});
					Tweener.addTween($iconPressBM, {alpha:0, time:$overInTime, transition:'easeInSine'});
				}
				
				dispatchEvent(new ButtonEvent(ButtonEvent.OVER));
			}
		}

		
		
		private function _onOut(event:MouseEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(event.buttonDown) dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT)); // drag out
			else {
				// roll out
				if($overOutTime > 0) {
					cacheAsBitmap = false;
					Tweener.addTween(this, {delay:$overOutTime, onComplete:function():void {
						cacheAsBitmap = true; 
					}});
				}

				Tweener.addTween($itemOverSBM, {alpha:0, time:$overOutTime, transition:'easeOutSine'});
				Tweener.addTween($textOutTextField, {alpha:$textOutAlpha, time:$overOutTime, transition:'easeOutSine'});
				Tweener.addTween($textOverTextField, {alpha:0, time:$overOutTime, transition:'easeInSine'});
				Tweener.addTween($textPressTextField, {alpha:0, time:$overOutTime, transition:'easeInSine'});

				if($isIconEnabled) {
					Tweener.addTween($iconOutBM, {alpha:$textOutAlpha, time:$overOutTime, transition:'easeOutSine'});
					Tweener.addTween($iconOverBM, {alpha:0, time:$overOutTime, transition:'easeInSine'});
					Tweener.addTween($iconPressBM, {alpha:0, time:$overOutTime, transition:'easeInSine'});
				}
				
				dispatchEvent(new ButtonEvent(ButtonEvent.ROLL_OUT));
			}
		}

		
		
		private function _onPress(event:MouseEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			parent.stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
			_currentDraggingButton = this;

			if($pressInTime > 0) {
				cacheAsBitmap = false;
				Tweener.addTween(this, {delay:$pressInTime, onComplete:function():void {
					cacheAsBitmap = true; 
				}});
			}

			Tweener.addTween($itemPressSBM, {alpha:1, time:$pressInTime, transition:'easeOutSine'});
			Tweener.addTween($textOutTextField, {alpha:0, time:$pressInTime, transition:'easeInSine'});
			Tweener.addTween($textOverTextField, {alpha:0, time:$pressInTime, transition:'easeInSine'});
			Tweener.addTween($textPressTextField, {alpha:$textPressAlpha, time:$pressInTime, transition:'easeOutSine'});

			if($isIconEnabled) {
				Tweener.addTween($iconOutBM, {alpha:0, time:$pressInTime, transition:'easeInSine'});
				Tweener.addTween($iconOverBM, {alpha:0, time:$pressInTime, transition:'easeInSine'});
				Tweener.addTween($iconPressBM, {alpha:$textPressAlpha, time:$pressInTime, transition:'easeOutSine'});
			}
			
			dispatchEvent(new ButtonEvent(ButtonEvent.PRESS));
		}

		
		
		private function _onRelease(event:MouseEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			parent.stage.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);

			if($pressOutTime > 0) {
				cacheAsBitmap = false;
				Tweener.addTween(this, {delay:$pressOutTime, onComplete:function():void {
					cacheAsBitmap = true; 
				}});
			}

			Tweener.addTween($itemPressSBM, {alpha:0, time:$pressOutTime, transition:'easeInSine'});
			Tweener.addTween($textPressTextField, {alpha:0, time:$pressOutTime, transition:'easeInSine'});
			if($isIconEnabled) Tweener.addTween($iconPressBM, {alpha:0, time:$pressOutTime, transition:'easeInSine'});

			if(event.currentTarget != $itemActiveSpr) {
				// release outside
				_forceRelease();
			}
			
			else if(_currentDraggingButton != this) {
				// drag confirm
				dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM));
			}
			
			else {
				// release inside
				_currentDraggingButton = null;
				
				Tweener.addTween($textOverTextField, {alpha:$textOverAlpha, time:$pressOutTime, transition:'easeOutSine'});
				
				if($isIconEnabled) Tweener.addTween($iconOverBM, {alpha:$textOverAlpha, time:$pressOutTime, transition:'easeOutSine'});
				
				dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE));
			}

			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}

		
		
		private function _forceRelease():void {
			_currentDraggingButton = null;
			
			Tweener.addTween($textOutTextField, {alpha:$textOutAlpha, time:$pressOutTime, transition:'easeOutSine'});
			Tweener.addTween($itemOverSBM, {alpha:0, time:$overOutTime, transition:'easeOutSine'});
			
			if($isIconEnabled) Tweener.addTween($iconOutBM, {alpha:$textOutAlpha, time:$pressOutTime, transition:'easeOutSine'});
			
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE));
		}

		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			$itemActiveSpr.mouseEnabled = value;
			if(!value) _forceRelease();
		}
	}
}

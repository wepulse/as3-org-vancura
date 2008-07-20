package org.vancura.controls {
	import flash.display.BitmapData;
	import flash.text.TextFormat;
	
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QTextField;
	import org.vancura.util.addChildren;
	import org.vancura.util.assign;
	import org.vancura.util.removeChildren;
	
	import caurina.transitions.Tweener;	

	
	
	/**
	 * Dropdown control.
	 * 
	 * TODO: Write documentation
	 * TODO: Click to erase
	 * TODO: More advanced error handling
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Dropdown extends MorphSprite {

		
		
		public static var defWidth:Number = DefaultControlSettings.DEF_WIDTH;
		public static var defHeight:Number = DefaultControlSettings.DEF_INPUT_HEIGHT;
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defBackSkin:BitmapData = null;
		public static var defDropSkin:BitmapData = null;
		public static var defDropIcon:BitmapData = null;
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
		public static var defTextOffsX:Number = DefaultControlSettings.DEF_INPUT_TEXT_OFFS_X;
		public static var defDropWidth:Number = DefaultControlSettings.DEF_DROPDOWN_BUTTON_WIDTH;
		public static var defDropOutAlpha:Number = DefaultControlSettings.DEF_TEXT_OUT_ALPHA;
		public static var defDropOutFilters:Array = DefaultControlSettings.DEF_TEXT_OUT_FILTERS;
		public static var defDropOutFormat:TextFormat = DefaultControlSettings.DEF_TEXT_OUT_FORMAT;
		public static var defDropOutOffsY:Number = DefaultControlSettings.DEF_TEXT_OUT_OFFS_Y;
		public static var defDropOverAlpha:Number = DefaultControlSettings.DEF_TEXT_OVER_ALPHA;
		public static var defDropOverFilters:Array = DefaultControlSettings.DEF_TEXT_OVER_FILTERS;
		public static var defDropOverFormat:TextFormat = DefaultControlSettings.DEF_TEXT_OVER_FORMAT;
		public static var defDropOverOffsY:Number = DefaultControlSettings.DEF_TEXT_OVER_OFFS_Y;
		public static var defDropPressAlpha:Number = DefaultControlSettings.DEF_TEXT_PRESS_ALPHA;
		public static var defDropPressFilters:Array = DefaultControlSettings.DEF_TEXT_PRESS_FILTERS;
		public static var defDropPressFormat:TextFormat = DefaultControlSettings.DEF_TEXT_PRESS_FORMAT;
		public static var defDropPressOffsY:Number = DefaultControlSettings.DEF_TEXT_PRESS_OFFS_Y;
		protected var $backBtn:Button;
		protected var $textOutTF:QTextField;
		protected var $textOverTF:QTextField;
		protected var $dropBtn:Button;
		protected var $overInTime:Number;
		protected var $overOutTime:Number;
		protected var $pressInTime:Number;
		protected var $pressOutTime:Number;
		protected var $textOutOffsY:Number;
		protected var $textOutAlpha:Number;
		protected var $textOverOffsY:Number;
		protected var $textOverAlpha:Number;
		protected var $textOffsX:Number;
		protected var $dropWidth:Number;
		private var _currentWidth:Number;
		private var _currentHeight:Number;
		private var _isEditing:Boolean;
		private var _areEventsEnabled:Boolean = true;

		
		
		public function Dropdown(c:Object = null) {
			super();

			if(c == null) c = new Object();

			// check for textformat
			if(defTextOutFormat == null || defTextOverFormat == null) throw new Error('Default dropdown text formats are not defined.');

			// get some data
			$overInTime = (c.overInTime != undefined) ? c.overInTime : defOverInTime;
			$overOutTime = (c.overOutTime != undefined) ? c.overOutTime : defOverOutTime;
			$pressInTime = (c.pressInTime != undefined) ? c.pressInTime : defPressInTime;
			$pressOutTime = (c.pressOutTime != undefined) ? c.pressOutTime : defPressOutTime;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$textOutOffsY = (c.textOutOffsY != undefined) ? c.textOutOffsY : defTextOutOffsY;
			$textOverOffsY = (c.textOverOffsY != undefined) ? c.textOverOffsY : defTextOverOffsY;
			$textOutAlpha = (c.textOutAlpha != undefined) ? c.textOutAlpha : defTextOutAlpha;
			$textOverAlpha = (c.textOverAlpha != undefined) ? c.textOverAlpha : defTextOverAlpha;
			$textOffsX = (c.textOffsX != undefined) ? c.textOffsX : defTextOffsX;
			$dropWidth = (c.dropWidth != undefined) ? c.dropWidth : defDropWidth;

			// generate back config data
			var backData:Object = {
				$overInTime:$overInTime, $overOutTime:$overOutTime, $pressInTime:$pressInTime, $pressOutTime:$pressOutTime, morphTime:(c.morphTime != undefined) ? c.morphTime : defMorphTime, skin:(c.backSkin != undefined) ? c.backSkin : defBackSkin
			};

			// generate drop config data
			var dropData:Object = {
				width:$dropWidth, textOutFilters:(c.dropOutFilters != undefined) ? c.dropOutFilters : defDropOutFilters, textOverFilters:(c.dropOverFilters != undefined) ? c.dropOverFilters : defDropOverFilters, textOutFilters:(c.dropOutFilters != undefined) ? c.dropOutFilters : defDropOutFilters, textOutFormat:(c.dropOutFormat != undefined) ? c.dropOutFormat : defDropOutFormat, textOverFormat:(c.dropOverFormat != undefined) ? c.dropOverFormat : defDropOverFormat, textPressFormat:(c.dropPressFormat != undefined) ? c.dropPressFormat : defDropPressFormat, $textOutAlpha:(c.dropOutAlpha != undefined) ? c.dropOutAlpha : defDropOutAlpha, $textOverAlpha:(c.dropOverAlpha != undefined) ? c.dropOverAlpha : defDropOverAlpha, textPressAlpha:(c.dropPressAlpha != undefined) ? c.dropPressAlpha : defDropPressAlpha, $textOutOffsY:(c.dropOutOffsY != undefined) ? c.dropOutOffsY : defDropOutOffsY, $textOverOffsY:(c.dropOverOffsY != undefined) ? c.dropOverOffsY : defDropOverOffsY, textPressOffsY:(c.dropPressOffsY != undefined) ? c.dropPressOffsY : defDropPressOffsY, $overInTime:$overInTime, $overOutTime:$overOutTime, $pressInTime:$pressInTime, $pressOutTime:$pressOutTime, morphTime:(c.morphTime != undefined) ? c.morphTime : defMorphTime, skin:(c.dropSkin != undefined) ? c.dropSkin : defDropSkin, icon:(c.dropIcon != undefined) ? c.dropIcon : defDropIcon
			};

			// generate text config data
			var textData:Object = {
				displayAsPassword:(c.displayAsPassword != undefined) ? c.displayAsPassword : false, maxChars:(c.maxChars != undefined) ? c.maxChars : undefined, restrict:(c.restrict != undefined) ? c.restrict : undefined, mouseEnabled:false, multiline:false, text:(c.text != undefined) ? c.text : ' '
			};
			
			// add graphics
			$backBtn = new Button(backData);
			$textOutTF = new QTextField(assign(textData, {defaultTextFormat:(c.textOutFormat != undefined) ? c.textOutFormat : defTextOutFormat, filters:(c.textOutFilters != undefined) ? c.textOutFilters : defTextOutFilters}));
			$textOverTF = new QTextField(assign(textData, {defaultTextFormat:(c.textOverFormat != undefined) ? c.textOverFormat : defTextOverFormat, filters:(c.textOverFilters != undefined) ? c.textOverFilters : defTextOverFilters, alpha:0}));
			$dropBtn = new Button(dropData);

			// add to display list
			addChildren(this, $backBtn, $textOutTF, $textOverTF, $dropBtn);

			// add event listeners
			$backBtn.addEventListener(ButtonEvent.OVER, _onOver, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.ROLL_OUT, _onOut, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.RELEASE_OUTSIDE, _onReleaseOutside, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.RELEASE_INSIDE, _onReleaseInside, false, 0, true);

			// set visual properties
			this.x = (c.x != undefined) ? c.x : 0;
			this.y = (c.y != undefined) ? c.y : 0;
			this.width = (c.width != undefined) ? c.width : defWidth;
			this.height = (c.height != undefined) ? c.height : defHeight;
			this.visible = (c.visible != undefined) ? c.visible : true;
			this.alpha = (c.alpha != undefined) ? c.alpha : 1;
			this.mask = (c.mask != undefined) ? c.mask : null;
		}

		
		
		public function destroy():void {
			// add to display list
			removeChildren(this, $backBtn, $textOutTF, $textOverTF, $dropBtn);

			// remove event listeners
			$backBtn.removeEventListener(ButtonEvent.OVER, _onOver);
			$backBtn.removeEventListener(ButtonEvent.ROLL_OUT, _onOut);
			$backBtn.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, _onReleaseOutside);
			$backBtn.removeEventListener(ButtonEvent.RELEASE_INSIDE, _onReleaseInside);

			// destroy subcontrols
			$backBtn.destroy();
		}

		
		
		override public function set width(value:Number):void {
			_currentWidth = value;
			$backBtn.width = _currentWidth;
			$dropBtn.x = _currentWidth - $dropWidth;
			_refreshAlign();
		}

		
		
		override public function set height(value:Number):void {
			_currentHeight = value;
			$backBtn.height = _currentHeight;
			$dropBtn.height = _currentHeight;
			_refreshAlign();
		}

		
		
		override public function get width():Number {
			return _currentWidth;
		}

		
		
		public function get isEditing():Boolean {
			return _isEditing;
			// TODO: 
		}

		
		
		private function _refreshAlign():void {
			var y:Number = Math.round((_currentHeight - $textOutTF.textHeight) / 2);

			$textOutTF.x = $textOverTF.x = $textOffsX;
			$textOutTF.width = $textOverTF.width = _currentWidth - 1 - $textOffsX - $dropWidth;
			$textOutTF.height = $textOverTF.height = $textOutTF.textHeight;
			$textOutTF.y = y + $textOutOffsY;
			$textOverTF.y = y + $textOverOffsY;
		}

		
		
		private function _setOut():void {
			Tweener.addTween($textOutTF, {alpha:$textOutAlpha, time:$pressOutTime, transition:'easeOutSine'});
			Tweener.addTween($textOverTF, {alpha:0, time:$pressOutTime, transition:'easeInSine'});
		}

		
		
		private function _onOver(event:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) {
				Tweener.addTween($textOutTF, {alpha:0, time:$overInTime, transition:'easeInSine'});
				Tweener.addTween($textOverTF, {alpha:$textOverAlpha, time:$overInTime, transition:'easeOutSine'});
			}
		}

		
		
		private function _onOut(event:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) _setOut();
		}

		
		
		private function _onReleaseInside(event:ButtonEvent):void {
			if(!_areEventsEnabled) return; // events are not enabled
		}

		
		
		private function _onReleaseOutside(event:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) _setOut();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			$backBtn.areEventsEnabled = value;
			$dropBtn.areEventsEnabled = value;
			if(!value) _setOut();
		}
	}
}

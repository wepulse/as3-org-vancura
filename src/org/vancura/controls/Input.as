package org.vancura.controls {
	import flash.text.TextField;	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.vancura.graphics.MorphSprite;
	import org.vancura.graphics.QTextField;
	import org.vancura.util.addChildren;
	import org.vancura.util.assign;
	import org.vancura.util.removeChildren;
	
	import com.gskinner.utils.StringUtils;
	
	import caurina.transitions.Tweener;	

	
	
	/**
	 * Input control.
	 * 
	 * TODO: Write documentation
	 * TODO: More advanced error handling
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 14, 2008
	 */
	public class Input extends MorphSprite {

		
		
		public static var defWidth:Number = DefaultControlSettings.DEF_WIDTH;
		public static var defHeight:Number = DefaultControlSettings.DEF_INPUT_HEIGHT;
		public static var defMorphTime:Number = DefaultControlSettings.DEF_MORPH_TIME;
		public static var defBackSkin:BitmapData = null;
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
		public static var defTextIntroAlpha:Number = DefaultControlSettings.DEF_TEXT_INTRO_ALPHA;
		public static var defTextIntroFilters:Array = DefaultControlSettings.DEF_TEXT_INTRO_FILTERS;
		public static var defTextIntroFormat:TextFormat = DefaultControlSettings.DEF_TEXT_INTRO_FORMAT;
		public static var defTextIntroOffsY:Number = DefaultControlSettings.DEF_TEXT_INTRO_OFFS_Y;
		public static var defTextOffsX:Number = DefaultControlSettings.DEF_INPUT_TEXT_OFFS_X;
		protected var $backBtn:Button;
		protected var $textOutTF:QTextField;
		protected var $textOverTF:QTextField;
		protected var $textPressTF:QTextField;
		protected var $textIntroTF:QTextField;
		protected var $overInTime:Number;
		protected var $overOutTime:Number;
		protected var $pressInTime:Number;
		protected var $pressOutTime:Number;
		protected var $textOutOffsY:Number;
		protected var $textOutAlpha:Number;
		protected var $textOverOffsY:Number;
		protected var $textOverAlpha:Number;
		protected var $textPressOffsY:Number;
		protected var $textPressAlpha:Number;
		protected var $textIntroOffsY:Number;
		protected var $textIntroAlpha:Number;
		protected var $textOffsX:Number;
		private var _currentWidth:Number;
		private var _currentHeight:Number;
		private var _isEditing:Boolean;
		private var _isIntroEnabled:Boolean;
		private var _areEventsEnabled:Boolean = true;

		
		
		public function Input(c:Object = null) {
			super();

			if(c == null) c = new Object();
			_isIntroEnabled = (c.introText != undefined);

			// check for textformat
			if(defTextOutFormat == null || defTextOverFormat == null || defTextPressFormat == null || defTextIntroFormat == null) throw new Error('Default input text formats are not defined.');

			// get some data
			$overInTime = (c.overInTime != undefined) ? c.overInTime : defOverInTime;
			$overOutTime = (c.overOutTime != undefined) ? c.overOutTime : defOverOutTime;
			$pressInTime = (c.pressInTime != undefined) ? c.pressInTime : defPressInTime;
			$pressOutTime = (c.pressOutTime != undefined) ? c.pressOutTime : defPressOutTime;
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$textOutOffsY = (c.textOutOffsY != undefined) ? c.textOutOffsY : defTextOutOffsY;
			$textOverOffsY = (c.textOverOffsY != undefined) ? c.textOverOffsY : defTextOverOffsY;
			$textPressOffsY = (c.textPressOffsY != undefined) ? c.textPressOffsY : defTextPressOffsY;
			$textIntroOffsY = (c.textIntroOffsY != undefined) ? c.textIntroOffsY : defTextIntroOffsY;
			$textOutAlpha = (c.textOutAlpha != undefined) ? c.textOutAlpha : defTextOutAlpha;
			$textOverAlpha = (c.textOverAlpha != undefined) ? c.textOverAlpha : defTextOverAlpha;
			$textPressAlpha = (c.textPressAlpha != undefined) ? c.textPressAlpha : defTextPressAlpha;
			$textIntroAlpha = (c.textIntroAlpha != undefined) ? c.textIntroAlpha : defTextIntroAlpha;
			$textOffsX = (c.textOffsX != undefined) ? c.textOffsX : defTextOffsX;
			$textOverAlpha = (c.textOverAlpha != undefined) ? c.textOverAlpha : defTextOverAlpha;

			// generate back config data
			var backData:Object = {
				$overInTime:$overInTime, $overOutTime:$overOutTime, $pressInTime:$pressInTime, $pressOutTime:$pressOutTime, morphTime:(c.morphTime != undefined) ? c.morphTime : defMorphTime, skin:(c.backSkin != undefined) ? c.backSkin : defBackSkin
			};

			// generate text config data
			var textData:Object = {
				displayAsPassword:(c.displayAsPassword != undefined) ? c.displayAsPassword : false, maxChars:(c.maxChars != undefined) ? c.maxChars : undefined, restrict:(c.restrict != undefined) ? c.restrict : undefined, mouseEnabled:false, multiline:false, text:(c.text != undefined) ? c.text : ' '
			};

			// add graphics
			$backBtn = new Button(backData);
			$textOutTF = new QTextField(assign(textData, {visible:!_isIntroEnabled, defaultTextFormat:(c.textOutFormat != undefined) ? c.textOutFormat : defTextOutFormat, filters:(c.textOutFilters != undefined) ? c.textOutFilters : defTextOutFilters}));
			$textOverTF = new QTextField(assign(textData, {visible:!_isIntroEnabled, defaultTextFormat:(c.textOverFormat != undefined) ? c.textOverFormat : defTextOverFormat, filters:(c.textOverFilters != undefined) ? c.textOverFilters : defTextOverFilters, alpha:0}));
			$textPressTF = new QTextField(assign(textData, {visible:!_isIntroEnabled, defaultTextFormat:(c.textPressFormat != undefined) ? c.textPressFormat : defTextPressFormat, filters:(c.textPressFilters != undefined) ? c.textPressFilters : defTextPressFilters, type:TextFieldType.INPUT, alpha:0, selectable:true}));
			$textIntroTF = new QTextField({visible:_isIntroEnabled, defaultTextFormat:(c.textIntroFormat != undefined) ? c.textIntroFormat : defTextIntroFormat, filters:(c.textIntroFilters != undefined) ? c.textIntroFilters : defTextIntroFilters, alpha:(c.textIntroAlpha != undefined) ? c.textIntroAlpha : defTextIntroAlpha, mouseEnabled:false, multiline:false, text:c.introText});

			// add to display list
			addChildren(this, $backBtn, $textIntroTF, $textPressTF, $textOutTF, $textOverTF);

			// add event listeners
			$backBtn.addEventListener(ButtonEvent.OVER, _onOver, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.ROLL_OUT, _onOut, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.RELEASE_OUTSIDE, _onReleaseOutside, false, 0, true);
			$backBtn.addEventListener(ButtonEvent.RELEASE_INSIDE, _onReleaseInside, false, 0, true);
			$textPressTF.addEventListener(Event.CHANGE, _onTextChange, false, 0, true);
			$textPressTF.addEventListener(FocusEvent.FOCUS_IN, _onFocusIn, false, 0, true);
			$textPressTF.addEventListener(FocusEvent.FOCUS_OUT, _onFocusOut, false, 0, true);

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
			removeChildren(this, $backBtn, $textIntroTF, $textPressTF, $textOutTF, $textOverTF);

			// remove event listeners
			$backBtn.removeEventListener(ButtonEvent.OVER, _onOver);
			$backBtn.removeEventListener(ButtonEvent.ROLL_OUT, _onOut);
			$backBtn.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, _onReleaseOutside);
			$backBtn.removeEventListener(ButtonEvent.RELEASE_INSIDE, _onReleaseInside);
			$textPressTF.removeEventListener(Event.CHANGE, _onTextChange);
			$textPressTF.removeEventListener(FocusEvent.FOCUS_IN, _onFocusIn);
			$textPressTF.removeEventListener(FocusEvent.FOCUS_OUT, _onFocusOut);

			// destroy subcontrols
			$backBtn.destroy();
		}

		
		
		override public function set width(value:Number):void {
			_currentWidth = value;
			$backBtn.width = _currentWidth;
			_refreshAlign();
		}

		
		
		override public function set height(value:Number):void {
			_currentHeight = value;
			$backBtn.height = _currentHeight;
			_refreshAlign();
		}

		
		
		override public function get width():Number {
			return _currentWidth;
		}

		
		
		public function get isEditing():Boolean {
			return _isEditing;
		}

		
		
		public function set text(value:String):void {
			$textPressTF.text = StringUtils.removeExtraWhitespace(value);
			_refreshText();
		}

		
		
		public function get text():String {
			return StringUtils.removeExtraWhitespace($textPressTF.text);
		}

		
		
		private function _refreshText():void {
			$textOutTF.text = $textOverTF.text = $textPressTF.text;
		}

		
		
		private function _refreshAlign():void {
			var y:Number = Math.round((_currentHeight - $textOutTF.textHeight) / 2);

			$textOutTF.x = $textOverTF.x = $textPressTF.x = $textIntroTF.x = $textOffsX;
			$textOutTF.width = $textOverTF.width = $textPressTF.width = $textIntroTF.width = _currentWidth - 1 - $textOffsX;
			$textOutTF.height = $textOverTF.height = $textPressTF.height = $textIntroTF.height = $textOutTF.textHeight;
			$textOutTF.y = y + $textOutOffsY;
			$textOverTF.y = y + $textOverOffsY;
			$textPressTF.y = y + $textPressOffsY;
			$textIntroTF.y = y + $textIntroOffsY;
		}

		
		
		private function _setOut():void {
			Tweener.addTween($textOutTF, {alpha:$textOutAlpha, time:$pressOutTime, transition:'easeOutSine'});
			Tweener.addTween($textOverTF, {alpha:0, time:$pressOutTime, transition:'easeInSine'});
			Tweener.addTween($textPressTF, {alpha:0, time:$pressOutTime, transition:'easeInSine'});
		}

		
		
		private function _setIn():void {
			Tweener.addTween($textOutTF, {alpha:0, time:$pressInTime, transition:'easeInSine'});
			Tweener.addTween($textOverTF, {alpha:0, time:$pressInTime, transition:'easeInSine'});
			Tweener.addTween($textPressTF, {alpha:$textPressAlpha, time:$pressInTime, transition:'easeOutSine'});
		}

		
		
		private function _onOver(e:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) {
				Tweener.addTween($textOutTF, {alpha:0, time:$overInTime, transition:'easeInSine'});
				Tweener.addTween($textOverTF, {alpha:$textOverAlpha, time:$overInTime, transition:'easeOutSine'});
				Tweener.addTween($textPressTF, {alpha:0, time:$overInTime, transition:'easeInSine'});
			}
		}

		
		
		private function _onOut(e:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) _setOut();
		}

		
		
		private function _onReleaseInside(e:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) stage.focus = $textPressTF;
		}

		
		
		private function _onReleaseOutside(e:ButtonEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			if(!_isEditing) _setOut();
		}

		
		
		private function _onFocusIn(e:FocusEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			_isEditing = true;
			$textPressTF.mouseEnabled = true;
			if(_isIntroEnabled) {
				$textIntroTF.visible = false;
				$textOutTF.visible = $textOverTF.visible = $textPressTF.visible = true;
			}
			_setIn();
		}

		
		
		private function _onFocusOut(e:FocusEvent):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			_isEditing = false;
			$textPressTF.mouseEnabled = false;
			if(_isIntroEnabled && this.text == '') {
				$textIntroTF.visible = true;
				$textOutTF.visible = $textOverTF.visible = $textPressTF.visible = false;
			}
			_setOut();
		}

		
		
		private function _onTextChange(e:Event):void {
			if(!_areEventsEnabled) return; 
			// events are not enabled
			_refreshText();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			if(!value) _setOut();
		}
	}
}

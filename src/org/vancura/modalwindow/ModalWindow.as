package org.vancura.modalwindow {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import org.vancura.graphics.*;
	import org.vancura.util.addChildren;
	import org.vancura.util.removeChildren;	

	
	
	/*
	Class: ModalWindow
	 *Modal Window.*

	Author: Vaclav Vancura <http://vaclav.vancura.org>

	Since: 24.01.2008

	- TODO: Change position and width according to stage width (automaticly?)
	- TODO: Write documentation
	 */
	public class ModalWindow extends Sprite {

		
		
		private static const _FONT:String = '_sans';
		private static const _BACKGROUND_COLOR:uint = 0xFFAAAA;
		private static const _BACKGROUND_ALPHA:Number = .9;
		private static const _TEXT_HORIZ_PADDING:uint = 10;
		private static const _TEXT_VERT_PADDING:uint = 5;
		private static const _DESCRIPTION_COLOR:uint = 0x660000;
		private static const _DESCRIPTION_FONT_SIZE:uint = 9;
		private var _fillSPR:Sprite;
		private var _descText:QTextField;
		private var _isVisible:Boolean;

		
		
		public function ModalWindow() {
			super();
			_addGraphics();
			_addEvents();
		}

		
		
		public function destroy():void {
			_removeGraphics();
			_removeEvents();
		}

		
		
		public function show(description:String = 'No description given'):void {
			_descText.text = description;
			_fillSPR.height = _descText.textHeight + _TEXT_VERT_PADDING * 3;
			_isVisible = true;
			this.visible = true;
		}

		
		
		public function hide():void {
			_isVisible = false;
			this.visible = false;
		}

		
		
		public override function set width(value:Number):void {
			_descText.width = value - _TEXT_HORIZ_PADDING * 2;
		}

		
		
		public override function set height(value:Number):void {
		}

		
		
		private function _addGraphics():void {
			// add components
			_fillSPR = new Sprite();
			_descText = new QTextField({embedFonts:false, x:_TEXT_HORIZ_PADDING, y:_TEXT_VERT_PADDING, height:400, defaultTextFormat:new TextFormat(_FONT, _DESCRIPTION_FONT_SIZE, _DESCRIPTION_COLOR)});

			// drawing
			Drawing.drawRect(_fillSPR, 0, 0, 2880, 100, _BACKGROUND_COLOR, _BACKGROUND_ALPHA);

			// set visual properties
			this.visible = false;

			// add to display list
			addChildren(this, _fillSPR, _descText);
		}

		
		
		private function _addEvents():void {
			addEventListener(MouseEvent.CLICK, _onClick, false, 0, true);
		}

		
		
		private function _removeGraphics():void {
			removeChildren(this, _fillSPR, _descText);
		}

		
		
		private function _removeEvents():void {
			removeEventListener(MouseEvent.CLICK, _onClick);
		}

		
		
		private function _onClick(event:MouseEvent):void {
			hide();
		}
	}
}

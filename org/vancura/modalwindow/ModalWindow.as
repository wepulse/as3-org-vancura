package org.vancura.modalwindow {



	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import org.vancura.graphics.*;



	/*
		Class: ModalWindow
		*Modal Window.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 24.01.2008

		- TODO: Change position and width according to stage width (automaticly?)
		- TODO: Write documentation
	*/
	public class ModalWindow extends Sprite {



		private static const __FONT:String = '_sans';
		private static const __BACKGROUND_COLOR:uint = 0xFFAAAA;
		private static const __BACKGROUND_ALPHA:Number = .9
		private static const __TEXT_HORIZ_PADDING:uint = 10;
		private static const __TEXT_VERT_PADDING:uint = 5;
		private static const __DESCRIPTION_COLOR:uint = 0x660000;
		private static const __DESCRIPTION_FONT_SIZE:uint = 9;

		private var __fillSPR:Sprite;
		private var __descText:QTextField;
		private var __isVisible:Boolean;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public function ModalWindow() {
			super();

			// add graphics and events
			__addGraphics();
			__addEvents()
		}



		public function destroy():void {
			// remove graphics and events
			__removeGraphics();
			__removeEvents();
		}



		public function show( description:String = 'No description given' ):void {
			__descText.text = description;
			__fillSPR.height = __descText.textHeight + __TEXT_VERT_PADDING * 3;
			__isVisible = true;
			this.visible = true;
		}



		public function hide():void {
			__isVisible = false;
			this.visible = false;
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		public override function set width( value:Number ):void {
			__descText.width = value - __TEXT_HORIZ_PADDING * 2;
		}



		public override function set height( value:Number ):void {
		}



		// --------------------------------------------- PRIVATE METHODS ---------------------------------------------



		private function __addGraphics():void {
			// add components
			__fillSPR = new Sprite();
			__descText = new QTextField( { embedFonts: false, x: __TEXT_HORIZ_PADDING, y: __TEXT_VERT_PADDING, height: 400, defaultTextFormat: new TextFormat( __FONT, __DESCRIPTION_FONT_SIZE, __DESCRIPTION_COLOR ) } );

			// drawing
			Drawing.drawRect( __fillSPR, 0, 0, 2880, 100, __BACKGROUND_COLOR, __BACKGROUND_ALPHA );

			// set visual properties
			this.visible = false;

			// add to display list
			addChildren( this, __fillSPR, __descText );
		}



		private function __addEvents():void {
			addEventListener( MouseEvent.CLICK, __onClick );
		}



		private function __removeGraphics():void {
			removeChildren( this, __fillSPR, __descText );
		}



		private function __removeEvents():void {
			removeEventListener( MouseEvent.CLICK, __onClick );
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function __onClick( event:MouseEvent ):void {
			hide();
		}



	}



}

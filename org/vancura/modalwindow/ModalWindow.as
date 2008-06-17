/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	TODO: Change position and width according to stage width (automaticly?)
*/



package org.vancura.modalwindow {



	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import org.vancura.graphics.*;



	/**
	 *	Modal window
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@since 24.01.2008
	 */
	public class ModalWindow extends Sprite {



		/** Default font */
		private static const __FONT:String = '_sans';

		/** Background color */
		private static const __BACKGROUND_COLOR:uint = 0xFFAAAA;

		/** Background alpha */
		private static const __BACKGROUND_ALPHA:Number = .9

		/** Horizontal text padding */
		private static const __TEXT_HORIZ_PADDING:uint = 10;

		/** Vertical text padding */
		private static const __TEXT_VERT_PADDING:uint = 5;

		/** Description color */
		private static const __DESCRIPTION_COLOR:uint = 0x660000;

		/** Description font size */
		private static const __DESCRIPTION_FONT_SIZE:uint = 9;

		private var __fillSPR:Sprite;
		private var __descText:QTextField;
		private var __isVisible:Boolean;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Modal window constructor.
		*/
		public function ModalWindow() {
			super();

			__fillSPR = new Sprite();

			__descText = new QTextField( {
				embedFonts: false,
				x: __TEXT_HORIZ_PADDING,
				y: __TEXT_VERT_PADDING,
				height: 400,
				defaultTextFormat: new TextFormat( __FONT, __DESCRIPTION_FONT_SIZE, __DESCRIPTION_COLOR )
			} );

			Drawing.drawRect( __fillSPR, 0, 0, 2880, 100, __BACKGROUND_COLOR, __BACKGROUND_ALPHA );

			this.visible = false;

			addEventListener( MouseEvent.CLICK, __onClick );

			addChild( __fillSPR );
			addChild( __descText );
		}



		/**
		*	Modal window destructor.
		*/
		public function destroy():void {
			removeChild( __fillSPR );
			removeChild( __descText );

			removeEventListener( MouseEvent.CLICK, __onClick );
		}



		/**
		*	Show modal window.
		*	@param description Description
		*/
		public function show( description:String = 'No description given' ):void {
			__descText.text = description;
			__fillSPR.height = __descText.textHeight + __TEXT_VERT_PADDING * 3;
			__isVisible = true;
			this.visible = true;
		}



		/**
		*	Hide modal window.
		*/
		public function hide():void {
			__isVisible = false;
			this.visible = false;
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		/**
		*	Set modal window width.
		*	@param value Width
		*/
		public override function set width( value:Number ):void {
			__descText.width = value - __TEXT_HORIZ_PADDING * 2;
		}



		/**
		*	Set modal window height.
		*	@param value Height
		*/
		public override function set height( value:Number ):void {
		}



		// --------------------------------------------- EVENTS ---------------------------------------------



		private function __onClick( event:MouseEvent ):void {
			hide();
		}



	}



}

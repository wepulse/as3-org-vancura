// TODO: Optimize conditionals



package org.vancura.graphics {



	import caurina.transitions.*;
	import flash.display.*;



	/**
	*	Morphable Sprite.
	* 	@langversion ActionScript 3
	*	@playerversion Flash 9.0.0
	*	@since 18.06.2008
	*/
	public class MorphSprite extends QSprite {



		public static var defMorphTime:Number = 1;
		public static var defMorphTransition:String = 'easeOutQuad';
		public static var defIsChangeWidthEnabled:Boolean = true;
		public static var defIsChangeHeightEnabled:Boolean = true;
		public static var defIsMorphXEnabled:Boolean = true;
		public static var defIsMorphYEnabled:Boolean = true;
		public static var defIsMorphWidthEnabled:Boolean = true;
		public static var defIsMorphHeightEnabled:Boolean = true;

		protected var morphTime:Number;
		protected var morphTransition:String;
		protected var isChangeWidthEnabled:Boolean;
		protected var isChangeHeightEnabled:Boolean;
		protected var isMorphXEnabled:Boolean;
		protected var isMorphYEnabled:Boolean;
		protected var isMorphWidthEnabled:Boolean;
		protected var isMorphHeightEnabled:Boolean;
		
		private var __oldCacheAsBitmap:Boolean;
		
		
		
		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------
		
		
		
		public function MorphSprite( c:Object = null ) {
			// if config is not defined, prepare it
			if( c == null ) c = new Object();
			
			// create parent QSprite
			super( c );
			
			// assign values
			morphTime = ( c.morphTime != null ) ? c.morphTime : defMorphTime;
			morphTransition = ( c.morphTransition != null ) ? c.morphTransition : defMorphTransition;
			isChangeWidthEnabled = ( c.changeWidthEnabled != null ) ? c.changeWidthEnabled : defIsChangeWidthEnabled;
			isChangeHeightEnabled = ( c.changeHeightEnabled != null ) ? c.changeHeightEnabled : defIsChangeHeightEnabled;
			isMorphXEnabled = ( c.morphXEnabled != null ) ? c.morphXEnabled : defIsMorphXEnabled;
			isMorphYEnabled = ( c.morphYEnabled != null ) ? c.morphYEnabled : defIsMorphYEnabled;
			isMorphWidthEnabled = ( c.morphWidthEnabled != null ) ? c.morphWidthEnabled : defIsMorphWidthEnabled;
			isMorphHeightEnabled = ( c.morphHeightEnabled != null ) ? c.morphHeightEnabled : defIsMorphHeightEnabled;
		}



		/**
		*	Method: Morph state
		*	
		*	Animate state change. Timing is taken from <morphTime>, transition from <morphTransition>.
		*	Follows status flags (<xMorphEnabled>, <yMorphEnabled>, <widthMorphEnabled> and <heightMorphEnabled>)
		*	
		*	Currently these options are available:
		*	
		*		x		- New X position
		*		y		- New Y position
		*		width	- New width
		*		height	- New height
		*/
		public function morph( c:Object ):void {
			__oldCacheAsBitmap = cacheAsBitmap;
			cacheAsBitmap = false;
			
			var o:Object = new Object();
			if( isMorphXEnabled ) o.x = x;
			if( isMorphYEnabled ) o.y = y;
			if( isMorphWidthEnabled ) o.width = width;
			if( isMorphHeightEnabled ) o.height = height;
			
			var t:Object = new Object();
			t.time = ( c.time != null ) ? c.time : morphTime;
			t.transition = ( c.transition != null ) ? c.transition : morphTransition;
			t.rounded = true;
			
			if( isMorphXEnabled ) t.x = ( c.x ) ? c.x : o.x;
			if( isMorphYEnabled ) t.y = ( c.y ) ? c.y : o.y;
			if( isMorphWidthEnabled ) t.width = ( c.width ) ? c.width : o.width;
			if( isMorphHeightEnabled ) t.height = ( c.height ) ? c.height : o.height;
			
			t.onUpdate = function():void {
				if( isMorphXEnabled ) x = this.x;
				if( isMorphYEnabled ) y = this.y;
				if( isMorphWidthEnabled ) width = this.width;
				if( isMorphHeightEnabled ) height = this.height;
			}
			
			t.onComplete = function():void {
				cacheAsBitmap = __oldCacheAsBitmap;
			}
			
			Tweener.addTween( o, t );
		}
		
		
		
		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------
		
		
		
		override public function set width( value:Number ):void {
			if( isChangeWidthEnabled ) super.width = value;
		}
		
		
		
		override public function set height( value:Number ):void {
			if( isChangeHeightEnabled ) super.height = value;
		}
		
		
		
	}
	


}

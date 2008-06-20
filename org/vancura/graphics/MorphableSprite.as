/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.graphics {



	import caurina.transitions.*;
	import flash.display.*;



	/**
	*	Morphable Sprite.
	* 	@langversion ActionScript 3
	*	@playerversion Flash 9.0.0
	*	@since 18.06.2008
	*/
	public class MorphableSprite extends Sprite {



		protected var morphTime:Number;
		protected var morphEasing:String = 'easeOutQuad';
		protected var changeWidthEnabled:Boolean = true;
		protected var changeHeightEnabled:Boolean = true;
		protected var morphXEnabled:Boolean = true;
		protected var morphYEnabled:Boolean = true;
		protected var morphWidthEnabled:Boolean = true;
		protected var morphHeightEnabled:Boolean = true;
		
		
		
		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Method: Morph state
		*	
		*	Animate state change. Timing is taken from <morphTime>, transition from <morphEasing>.
		*	Follows status flags (<xMorphEnabled>, <yMorphEnabled>, <widthMorphEnabled> and <heightMorphEnabled>)
		*	
		*	Currently these options are available:
		*	
		*		x		- New X position
		*		y		- New Y position
		*		width	- New width
		*		height	- New height
		*	
		*	- TODO: Optimize conditionals
		*/
		public function morph( c:Object ):void {
			cacheAsBitmap = false;
			
			var o:Object = new Object();
			if( morphXEnabled ) o.x = x;
			if( morphYEnabled ) o.y = y;
			if( morphWidthEnabled ) o.width = width;
			if( morphHeightEnabled ) o.height = height;
			
			var t:Object = new Object();
			t.time = morphTime;
			t.rounded = true;
			t.transition = morphEasing;
			
			if( morphXEnabled ) t.x = ( c.x ) ? c.x : o.x;
			if( morphYEnabled ) t.y = ( c.y ) ? c.y : o.y;
			if( morphWidthEnabled ) t.width = ( c.width ) ? c.width : o.width;
			if( morphHeightEnabled ) t.height = ( c.height ) ? c.height : o.height;
			
			t.onUpdate = function():void {
				if( morphXEnabled ) x = this.x;
				if( morphYEnabled ) y = this.y;
				if( morphWidthEnabled ) width = this.width;
				if( morphHeightEnabled ) height = this.height;
			}
			
			t.onComplete = function():void {
				cacheAsBitmap = true;
			}
			
			Tweener.addTween( o, t );
		}
		
		
		
		override public function set width( value:Number ):void {
			if( changeWidthEnabled ) super.width = value;
		}
		
		
		
		override public function set height( value:Number ):void {
			if( changeHeightEnabled ) super.height = value;
		}
		
		
		
	}
	


}

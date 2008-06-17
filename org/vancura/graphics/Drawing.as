/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.graphics {



	import flash.display.*;



	/**
	*	Some special drawing methods.
	* 	@langversion ActionScript 3
	*	@playerversion Flash 9.0.0
	*	@since 01.01.2008
	*/
	public final class Drawing {



		/** Default alpha */
		public static const DEFAULT_ALPHA:Number = 1;

		/** Default color */
		public static const DEFAULT_COLOR:uint = 0xFF0000;

		/** Default height */
		public static const DEFAULT_HEIGHT:Number = 100;

		/** Default radius */
		public static const DEFAULT_RADIUS:Number = 20;

		/** Default segments */
		public static const DEFAULT_SEGMENTS:Number = 6;

		/** Default thickness */
		public static const DEFAULT_THICKNESS:Number = 0;

		/** Default width */
		public static const DEFAULT_WIDTH:Number = 100;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Draw rectangle.
		*	@param canvas Canvas Sprite
		*	@param x X
		*	@param y Y
		*	@param width Width
		*	@param height Height
		*	@param color Color
		*	@param alpha Alpha
		*/
		public static function drawRect( canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA ):void {
			with( canvas.graphics ) {
				beginFill( color, alpha );
				moveTo( x, y );
				lineTo( x, y + height );
				lineTo( x + width, y + height );
				lineTo( x + width, y );
				lineTo( x, y );
				endFill();
			}
		}



		/**
		*	Draw circle.
		*	@param canvas Canvas Sprite
		*	@param x X
		*	@param y Y
		*	@param radius Radius
		*	@param color Color
		*	@param alpha Alpha
		*/
		public static function drawCircle( canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA ):void {
			with( canvas.graphics ) {
				beginFill( color, alpha );
				drawCircle( 0, 0, radius );
				endFill();
			}
		}



		/**
		*	Draw rounded rectangle.
		*	@param canvas Canvas Sprite
		*	@param x X
		*	@param y Y
		*	@param width Width
		*	@param height Height
		*	@param radius Radius
		*	@param color Color
		*	@param alpha Alpha
		*/
		public static function drawRoundedRect( canvas:Sprite, x:Number, y:Number, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA ):void {
			with( canvas.graphics ) {
				beginFill( color, alpha );
				moveTo( radius + x, y );
				lineTo( width - radius + x, y );
				curveTo( width + x, y, width + x, radius + y );
				lineTo( width + x, height - radius + y );
				curveTo( width + x, height + y, width - radius + x, height + y );
				lineTo( radius + x, height + y );
				curveTo( x, height + y, x, height - radius + y );
				lineTo( x, radius + y );
				curveTo( x, y, radius + x, y );
				endFill();
			}
		}



		/**
		*	Draw pie.
		*	@param canvas Canvas Sprite
		*	@param centerX X center
		*	@param centerY Y center
		*	@param radiusX X radius
		*	@param radiusY Y radius
		*	@param segments Segments
		*	@param angle1 Angle 1
		*	@param angle2 Angle 2
		*	@param color Color
		*	@param alpha Alpha
		*/
		public static function drawPie( canvas:Sprite, centerX:Number, centerY:Number, radiusX:Number = DEFAULT_RADIUS, radiusY:Number = DEFAULT_RADIUS, segments:int = DEFAULT_SEGMENTS, angle1:Number = 0, angle2:Number = 360, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA ):void {
			var segm:Number;
			var grad:Number;
			var x1:Number;
			var y1:Number;
			var rad:Number = Math.PI / 180;

			canvas.graphics.beginFill( color, alpha );

			if( !angle1 && !angle2 || angle1 == angle2 ) {
				// full circle
				grad = 360;
				segm = grad / segments;
				x1 = radiusX + centerX;
				y1 = centerY;
				canvas.graphics.moveTo( x1, y1 );
			} else {
				// not a full circle
				if( angle1 > angle2 ) angle1 -= 360;
				x1 = radiusX * Math.cos( angle1 * rad ) + centerX;
				y1 = radiusY * Math.sin( angle1 * rad ) + centerY;
				grad = angle2 - angle1;
				segm = grad / segments;
				canvas.graphics.moveTo( centerX, centerY );
				canvas.graphics.lineTo( x1, y1 );
			}

			for( var s:Number = segm + angle1; s < grad + 0.1 + angle1; s += segm ) {
				var x2:Number = radiusX * Math.cos( ( s - segm / 2 ) * rad ) + centerX;
				var y2:Number = radiusY * Math.sin( ( s - segm / 2 ) * rad ) + centerY;
				var x3:Number = radiusX * Math.cos( s * rad ) + centerX;
				var y3:Number = radiusY * Math.sin( s * rad ) + centerY;
				var cx:Number = 2 * x2 - 0.5 * ( x1 + x3 );
				var cy:Number = 2 * y2 - 0.5 * ( y1 + y3 );
				x1 = x3;
				y1 = y3;
				canvas.graphics.curveTo( cx, cy, x3, y3 );
			}
			if( grad != 360 ) canvas.graphics.lineTo( centerX, centerY );

			canvas.graphics.endFill();
		}



		/**
		*	Stroke rectangle.
		*	@param canvas Canvas Sprite
		*	@param x X
		*	@param y Y
		*	@param width Width
		*	@param height Height
		*	@param color Color
		*	@param alpha Alpha
		*	@param thickness Thickness
		*/
		public static function strokeRect( canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS ):void {
			with( canvas.graphics ) {
				lineStyle( thickness, color, alpha, true );
				moveTo( x, y );
				lineTo( x, y + height - 1 );
				lineTo( x + width - 1, y + height - 1 );
				lineTo( x + width - 1, y );
				lineTo( x, y );
			}
		}



		/**
		*	Line.
		*	@param canvas Canvas Sprite
		*	@param x1 X1
		*	@param y1 Y1
		*	@param x2 X2
		*	@param y2 Y2
		*	@param color Color
		*	@param alpha Alpha
		*	@param thickness Thickness
		*/
		public static function strokeLine( canvas:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS ):void {
			with( canvas.graphics ) {
				lineStyle( thickness, color, alpha, true );
				moveTo( x1, y1 );
				lineTo( x2, y2 );
			}
		}



	}


}

﻿package org.vancura.graphics {



	import flash.display.*;



	/*
		Class: Drawing
		*Some special drawing methods.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 01.01.2008
	*/
	public final class Drawing {



		/*
			Constants: Default settings

				DEFAULT_WIDTH		- Default width (100)
				DEFAULT_HEIGHT		- Default height (100)
				DEFAULT_COLOR		- Default color (0xFF0000)
				DEFAULT_ALPHA		- Default alpha (1)
				DEFAULT_THICKNESS	- Default thickness (0)
				DEFAULT_RADIUS		- Default radius (20)
				DEFAULT_SEGMENTS	- Default segments (6)
		*/
		public static const DEFAULT_WIDTH:Number = 100;
		public static const DEFAULT_HEIGHT:Number = 100;
		public static const DEFAULT_COLOR:uint = 0xFF0000;
		public static const DEFAULT_ALPHA:Number = 1;
		public static const DEFAULT_THICKNESS:Number = 0;
		public static const DEFAULT_RADIUS:Number = 20;
		public static const DEFAULT_SEGMENTS:Number = 6;



		/*
			Method: drawRect

			Shortcut to draw a rectangle.

			Parameters:

				canvas		- Canvas to draw on
				x			- X position
				y			- Y position
				width		- Width (if not specified, <DEFAULT_WIDTH> used)
				height		- Height (if not specified, <DEFAULT_HEIGHT> used)
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		*/
		public static function drawRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			with(canvas.graphics) {
				beginFill(color, alpha);
				drawRect(x, y, width, height);
				endFill();
			}
		}



		/*
			Method: drawCircle

			Shortcut to draw a circle.

			Parameters:

				canvas		- Canvas to draw on
				x			- X center position
				y			- Y center position
				radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		*/
		public static function drawCircle(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			with(canvas.graphics) {
				beginFill(color, alpha);
				drawCircle(x, y, radius);
				endFill();
			}
		}



		/*
			Method: drawRoundRect

			Shortcut to draw a rounded rectangle.

			Parameters:

				canvas		- Canvas to draw on
				x			- X position
				y			- Y position
				width		- Width (if not specified, <DEFAULT_WIDTH> used)
				height		- Height (if not specified, <DEFAULT_HEIGHT> used)
				radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		*/
		public static function drawRoundRect(canvas:Sprite, x:Number, y:Number, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			with(canvas.graphics) {
				beginFill(color, alpha);
				drawRoundRect(x, y, width, height, radius, radius);
				endFill();
			}
		}



		/*
			Method: drawPie

			Shortcut to draw a pie.

			Parameters:

				canvas		- Canvas to draw on
				x			- X center position
				y			- Y center position
				radius		- Radius (if not specified, <DEFAULT_RADIUS> used)
				segments	- Segments (if not specified, <DEFAULT_SEGMENTS> used)
				angle1		- Angle1 (if not specified, 0 used)
				angle2		- Angle2 (if not specified, 360 used)
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
		*/
		public static function drawPie(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, segments:int = DEFAULT_SEGMENTS, angle1:Number = 0, angle2:Number = 360, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			var segm:Number;
			var grad:Number;
			var x1:Number;
			var y1:Number;
			var rad:Number = Math.PI / 180;

			canvas.graphics.beginFill(color, alpha);

			if(!angle1 && !angle2 || angle1 == angle2) {
				// full circle
				grad = 360;
				segm = grad / segments;
				x1 = radius + x;
				y1 = y;
				canvas.graphics.moveTo(x1, y1);
			} else {
				// not a full circle
				if(angle1 > angle2) angle1 -= 360;
				x1 = radius * Math.cos(angle1 * rad) + x;
				y1 = radius * Math.sin(angle1 * rad) + y;
				grad = angle2 - angle1;
				segm = grad / segments;
				canvas.graphics.moveTo(x, y);
				canvas.graphics.lineTo(x1, y1);
			}

			for(var s:Number = segm + angle1; s < grad + 0.1 + angle1; s += segm) {
				var x2:Number = radius * Math.cos((s - segm / 2) * rad) + x;
				var y2:Number = radius * Math.sin((s - segm / 2) * rad) + y;
				var x3:Number = radius * Math.cos(s * rad) + x;
				var y3:Number = radius * Math.sin(s * rad) + y;
				var cx:Number = 2 * x2 - 0.5 * (x1 + x3);
				var cy:Number = 2 * y2 - 0.5 * (y1 + y3);
				x1 = x3;
				y1 = y3;
				canvas.graphics.curveTo(cx, cy, x3, y3);
			}
			if(grad != 360) canvas.graphics.lineTo(x, y);

			canvas.graphics.endFill();
		}



		/*
			Method: strokeRect

			Shortcut to stroke a rectangle.

			Parameters:

				canvas		- Canvas to draw on
				x			- X position
				y			- Y position
				width		- Width (if not specified, <DEFAULT_WIDTH> used)
				height		- Height (if not specified, <DEFAULT_HEIGHT> used)
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
				thickness	- Thickness (if not specified, <DEFAULT_THICKNESS> used)
		*/
		public static function strokeRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS):void {
			with(canvas.graphics) {
				lineStyle(thickness, color, alpha, true);
				drawRect(x, y, width, height);
			}
		}



		/*
			Method: strokeLine

			Shortcut to draw a line.

			Parameters:

				canvas		- Canvas to draw on
				x1			- Start X position
				y1			- Start Y position
				x2			- End X position
				y2			- End Y position
				color		- Color (if not specified, <DEFAULT_COLOR> used)
				alpha		- Alpha (if not specified, <DEFAULT_ALPHA> used)
				thickness	- Thickness (if not specified, <DEFAULT_THICKNESS> used)
		*/
		public static function strokeLine(canvas:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS):void {
			with(canvas.graphics) {
				lineStyle(thickness, color, alpha, true);
				moveTo(x1, y1);
				lineTo(x2, y2);
			}
		}



	}


}

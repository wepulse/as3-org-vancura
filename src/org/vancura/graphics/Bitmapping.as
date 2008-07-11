package org.vancura.graphics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;	

	
	
	/**
	 * Some special bitmapping methods.
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Jun 17, 2008
	 */
	public final class Bitmapping {

		
		
		/**
		 * Convert an embedded class to BitmapData.
		 * @param source Source Bitmap or BitmapData
		 * @throws TypeError if source is not Bitmap or BitmapData
		 * @return BitmapData
		 */
		public static function embed2BD(source:*):BitmapData {
			if(source is Bitmap) return source.bitmapData;
			else if(source is BitmapData) return source;
			else throw new TypeError('Bitmap or BitmapData needed');
		}

		
		
		/**
		 * Crop a BitmapData object.
		 * @param height Cropped area height
		 * @param source Source BitmapData
		 * @param width Cropped area width
		 * @param x Cropped area X
		 * @param y Cropped area Y
		 * @return Cropped BitmapData
		 */
		public static function crop(source:BitmapData, x:uint, y:uint, width:uint, height:uint):BitmapData {
			var o:BitmapData = new BitmapData(width, height);
			o.copyPixels(source, new Rectangle(x, y, width, height), new Point(0, 0));
			return o;
		}
	}
}

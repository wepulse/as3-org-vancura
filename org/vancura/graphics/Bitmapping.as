package org.vancura.graphics {



	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;



	/*
		Class: Bitmapping
		*Some special bitmapping methods.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Since: 17.06.2008
	*/
	public final class Bitmapping {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/*
			Method: embed2BD

			Convert an embeded class to BitmapData.
			If source is not Bitmap or BitmapData, method throws an Error with a description.

			Parameters:

				source	- Source image as Bitmap or BitmapData

			Returns:

				BitmapData object
		*/
		public static function embed2BD( source:* ):BitmapData {
			if( source is Bitmap ) return source.bitmapData;
			else if( source is BitmapData ) return source;
			else throw new TypeError( 'Bitmap or BitmapData needed' );
		}



		/*
			Method: crop

			Crop a BitmapData object.

			Parameters:

				source		- Source image as BitmapData
				x			- Crop X position
				y			- Crop Y position
				width		- Crop width
				height		- Crop height

			Returns:

				Cropped image as BitmapData
		*/
		public static function crop( source:BitmapData, x:uint, y:uint, width:uint, height:uint ):BitmapData {
			var o:BitmapData = new BitmapData( width, height );
			o.copyPixels( source, new Rectangle( x, y, width, height ), new Point( 0, 0 ) );
			return o;
		}



	}


}

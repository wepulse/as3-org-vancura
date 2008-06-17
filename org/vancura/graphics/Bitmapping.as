/**
*	Copyright 2008 Vaclav Vancura (vaclav.vancura.org)
*
*	@author Vaclav Vancura (vaclav.vancura.org)
*/



package org.vancura.graphics {



	import flash.display.*;
	import flash.geom.*;



	/**
	*	Some special bitmapping methods.
	* 	@langversion ActionScript 3
	*	@playerversion Flash 9.0.0
	*	@since 17.06.2008
	*/
	public final class Bitmapping {



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		 *	Convert an embed class to BitmapData.
		 *	@param source Embed class
		 *	@return BitmapData output
		 */
		public static function embed2BD( source:* ):BitmapData {
			if( source is Bitmap ) return source.bitmapData;
			else if( source is BitmapData ) return source;
			else throw new Error( 'Invalid embed object (Bitmap or BitmapData needed)' );
		}
		
		
		
		/**
		*	Crop a BitmapData object and get a copy.
		*	@param source BitmapData source
		*	@param x X
		*	@param y Y
		*	@param width Width
		*	@param height Height
		*/
		public static function crop( source:BitmapData, x:uint, y:uint, width:uint, height:uint ):BitmapData {
			var o:BitmapData = new BitmapData( width, height );
			o.copyPixels( source, new Rectangle( x, y, width, height ), new Point( 0, 0 ) );
			return o;
		}



	}


}

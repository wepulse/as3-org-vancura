package org.vancura.graphics {
	import caurina.transitions.*;

	import flash.display.*;

	
	
	/*
	Class: MorphSprite
	 *Morphable sprite.*

	Author: Vaclav Vancura <http://vaclav.vancura.org>

	Since: 18.06.2008

	- TODO: Optimize conditionals
	- TODO: Add some examples to docs
	 */
	public class MorphSprite extends QSprite {

		
		
		/*
		Variables: Default settings

		defMorphTime				- Default morphing time in seconds (1)
		defMorphTransition			- Default morphing transition ('easeOutQuad')
		defIsChangeWidthEnabled		- Default width change flag (true)
		defIsChangeHeightEnabled	- Default height change flag (true)
		defIsMorphXEnabled			- Default X morphing flag (true)
		defIsMorphYEnabled			- Default Y morphing flag (true)
		defIsMorphWidthEnabled		- Default width morphing flag (true)
		defIsMorphHeightEnabled		- Default height morphing flag (true)
		 */
		public static var defMorphTime:Number = 1;
		public static var defMorphTransition:String = 'easeOutQuad';
		public static var defIsChangeWidthEnabled:Boolean = true;
		public static var defIsChangeHeightEnabled:Boolean = true;
		public static var defIsMorphXEnabled:Boolean = true;
		public static var defIsMorphYEnabled:Boolean = true;
		public static var defIsMorphWidthEnabled:Boolean = true;
		public static var defIsMorphHeightEnabled:Boolean = true;
		/*
		Variables: Protected variables

		morphTime					- Current morphing time in seconds
		morphTransition				- Current morphing transition
		isChangeWidthEnabled		- Current width change flag
		isChangeHeightEnabled		- Current height change flag
		isMorphXEnabled				- Current X morphing flag
		isMorphYEnabled				- Current Y morphing flag
		isMorphWidthEnabled			- Current width morphing flag
		isMorphHeightEnabled		- Current height morphing flag
		 */
		protected var $morphTime:Number;
		protected var $morphTransition:String;
		protected var $isChangeWidthEnabled:Boolean;
		protected var $isChangeHeightEnabled:Boolean;
		protected var $isMorphXEnabled:Boolean;
		protected var $isMorphYEnabled:Boolean;
		protected var $isMorphWidthEnabled:Boolean;
		protected var $isMorphHeightEnabled:Boolean;
		/*
		Variables: Private variables

		_oldCacheAsBitmap			- Old cacheAsBitmap value
		 */
		private var _oldCacheAsBitmap:Boolean;

		
		
		/*
		Constructor: MorphSprite

		Parameters:

		c	- Config object

		Currently these options are available (set in c Object):

		morphTime				- Morphing time in seconds. If not defined, <defMorphTime> used instead.
		morphTransition			- Morphing transition. If not defined, <defMorphTransition> used instead.
		isChangeWidthEnabled	- Width change flag. If not defined, <defIsChangeWidthEnabled> used instead.
		isChangeHeightEnabled	- Height change flag. If not defined, <defIsChangeHeightEnabled> used instead.
		isMorphXEnabled			- X morphing flag. If not defined, <defIsMorphXEnabled> used instead.
		isMorphYEnabled			- Y morphing flag. If not defined, <defIsMorphYEnabled> used instead.
		isMorphWidthEnabled		- Width morphing flag. If not defined, <defIsMorphWidthEnabled> used instead.
		isMorphHeightEnabled	- Height morphing flag. If not defined, <defIsMorphHeightEnabled> used instead.
		 */
		public function MorphSprite(c:Object = null) {
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			// create parent QSprite
			super(c);

			// assign values
			$morphTime = (c.morphTime != undefined) ? c.morphTime : defMorphTime;
			$morphTransition = (c.morphTransition != undefined) ? c.morphTransition : defMorphTransition;
			$isChangeWidthEnabled = (c.changeWidthEnabled != undefined) ? c.changeWidthEnabled : defIsChangeWidthEnabled;
			$isChangeHeightEnabled = (c.changeHeightEnabled != undefined) ? c.changeHeightEnabled : defIsChangeHeightEnabled;
			$isMorphXEnabled = (c.morphXEnabled != undefined) ? c.morphXEnabled : defIsMorphXEnabled;
			$isMorphYEnabled = (c.morphYEnabled != undefined) ? c.morphYEnabled : defIsMorphYEnabled;
			$isMorphWidthEnabled = (c.morphWidthEnabled != undefined) ? c.morphWidthEnabled : defIsMorphWidthEnabled;
			$isMorphHeightEnabled = (c.morphHeightEnabled != undefined) ? c.morphHeightEnabled : defIsMorphHeightEnabled;
		}

		
		
		/*
		Method: morph

		Animate state change. Timing is taken from <morphTime>, transition from <morphTransition>.
		Follows status flags (<isMorphXEnabled>, <isMorphYEnabled>, <isMorphWidthEnabled> and <isMorphHeightEnabled>)

		Parameters:

		c		- Config object

		Currently these options are available (set in c Object):

		x		- New X position
		y		- New Y position
		width	- New width
		height	- New height
		 */
		public function morph(c:Object):void {
			_oldCacheAsBitmap = cacheAsBitmap;
			cacheAsBitmap = false;

			var o:Object = new Object();
			if($isMorphXEnabled) o.x = x;
			if($isMorphYEnabled) o.y = y;
			if($isMorphWidthEnabled) o.width = width;
			if($isMorphHeightEnabled) o.height = height;

			var t:Object = new Object();
			t.time = (c.time != undefined) ? c.time : $morphTime;
			t.transition = (c.transition != undefined) ? c.transition : $morphTransition;
			t.rounded = true;

			if($isMorphXEnabled) t.x = (c.x != undefined) ? c.x : o.x;
			if($isMorphYEnabled) t.y = (c.y != undefined) ? c.y : o.y;
			if($isMorphWidthEnabled) t.width = (c.width != undefined) ? c.width : o.width;
			if($isMorphHeightEnabled) t.height = (c.height != undefined) ? c.height : o.height;

			t.onUpdate = function():void {
				if($isMorphXEnabled) x = this.x;
				if($isMorphYEnabled) y = this.y;
				if($isMorphWidthEnabled) width = this.width;
				if($isMorphHeightEnabled) height = this.height;
			};

			t.onComplete = function():void {
				cacheAsBitmap = _oldCacheAsBitmap;
			};

			Tweener.addTween(o, t);
		}

		
		
		/*
		Method: width

		If width change flag is set, directly change width.

		Parameters:

		value	- New width
		 */
		override public function set width(value:Number):void {
			if($isChangeWidthEnabled) super.width = value;
		}

		
		
		/*
		Method: height

		If height change flag is set, directly change height.

		Parameters:

		value	- New height
		 */
		override public function set height(value:Number):void {
			if($isChangeHeightEnabled) super.height = value;
		}
	}
}

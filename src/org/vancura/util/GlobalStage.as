package org.vancura.util {
	import flash.display.*;	

	
	
	/**
	 * GlobalStage.
	 * 
	 * Original:
	 * http://www.kirupa.com/forum/showthread.php?p=1939920
	 * Created by Matthew Lloyd (http://www.Matt-Lloyd.co.uk)
	 * This is release under a Creative Commons license.
	 * More information can be found here: (http://creativecommons.org/licenses/by-nc-sa/2.0/uk)
	 * 
	 * TODO: Write documentation
	 * 
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 * @since Mar 22, 2008
	 */
	public class GlobalStage extends Sprite {

		
		
		private static var _instance:GlobalStage = null;

		
		
		public static function init(stg:Stage):void {
			stg.addChild(GlobalStage.instance);
		}

		
		
		public static function get instance():GlobalStage {
			if(_instance == null) _instance = new GlobalStage();
			return _instance;
		}

		
		
		public static function get stage():Stage {
			return instance.stage;
		}
	}
}

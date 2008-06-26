package org.vancura.util {



    import flash.display.*;



	/*
		Class: GlobalStage
		*GlobalStage.*

		Author: Vaclav Vancura <http://vaclav.vancura.org>

		Original:

			http://www.kirupa.com/forum/showthread.php?p=1939920
			Created by Matthew Lloyd <http://www.Matt-Lloyd.co.uk>
			This is release under a Creative Commons license.
			More information can be found here: <http://creativecommons.org/licenses/by-nc-sa/2.0/uk>

		Since: 26.06.2008

		- TODO: Write documentation
	*/
    public class GlobalStage extends Sprite {



		public static const CLASSID:String = 'org.vancura.util.GlobalStage';
		public static const AUTHOR:String = 'Copyright 2008 Václav Vančura (www.Vaclav.Vancura.org).';

		private static var __instance:GlobalStage = null;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		public static function init( stg:Stage ):void {
			stg.addChild( GlobalStage.instance );
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		public static function get instance():GlobalStage {
			if( __instance == null ) __instance = new GlobalStage();
			return __instance;
		}



		public static function get stage():Stage {
			return instance.stage;
		}



	}



}

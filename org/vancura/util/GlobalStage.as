/*
*	http://www.kirupa.com/forum/showthread.php?p=1939920
*
*	GlobalStage
*	version 1.1.0
*	Created by Matthew Lloyd
*	http://www.Matt-Lloyd.co.uk
*	Advanced by Vaclav Vancura
*	http://www.Vaclav.Vancura.org
*
*	This is release under a Creative Commons license.
*	More information can be found here:
*	http://creativecommons.org/licenses/by-nc-sa/2.0/uk/
*
*/



package org.vancura.util {



    import flash.display.*;



    public class GlobalStage extends Sprite {



		public static const CLASSID:String = 'org.vancura.util.GlobalStage';
		public static const AUTHOR:String = 'Copyright 2008 Václav Vančura (www.Vaclav.Vancura.org).';

		private static var __instance:GlobalStage = null;



		// --------------------------------------------- PUBLIC METHODS ---------------------------------------------



		/**
		*	Init global stage.
		*	@param stg Stage
		*/
		public static function init( stg:Stage ):void {
			stg.addChild( GlobalStage.instance );
		}



		// --------------------------------------------- SETTERS & GETTERS ---------------------------------------------



		/**
		*	Get instance of global stage.
		*	@return Global stage instance
		*/
		public static function get instance():GlobalStage {
			if( __instance == null ) __instance = new GlobalStage();
			return __instance;
		}



		/**
		*	Get stage.
		*	@return Stage
		*/
		public static function get stage():Stage {
			return instance.stage;
		}



	}



}

package com.subfty.angrymonument;

import com.subfty.sub.display.ImgSprite;
import com.subfty.sub.helpers.FixedAspectRatio;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.Event;
import nme.Lib;
import nme.media.Sound;

/**
 * ...
 * @author Filip Loster
 */

class Main extends Sprite {
	
	public static var GAME_STARTED:Bool = false;
	public static var points:Int = 0;
	public static var gtime:Int = 0;
	
	//public static var STAGE_W:Int = 1280;
	//public static var STAGE_H:Int = 768;
	public static var STAGE_W:Int = 720;
	public static var STAGE_H:Int = 720;
									
	public static var aspect:FixedAspectRatio;
	
  //TIMER
	private static var prevFrame:Int = -1;
	public static var delta:Int = 0;
	
  //SCENES
	public static var game:Game;
	
	public function new() {
		super();
		
		aspect = new FixedAspectRatio(this, STAGE_W, STAGE_H);		

		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
		
	  //INITIATION
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, step);
		
		var stage:Stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		game = new Game(this);
		
		GAME_STARTED = false;
		
	}

	public static function killGame() {
		GAME_STARTED = false;
		game.archOverlord.killAll();
	}
	
	public static function setPoints(p:Int) {
		points = p;
		game.background.scoreVal.text = points + "pts";
	}
	public static function setTime(t:Int) {
		gtime = t;
		game.background.timeVal.text = "0." + (Math.floor(t / 1000));
	}
	
	static public function main() {
		Lib.current.addChild(new Main());
	}
	
	private function init(e) {
		aspect.fix(null);
	}
	
	function step(e:Event) {
	  //CALCULATING DELTA
		if (prevFrame < 0) prevFrame = Lib.getTimer();
		delta = Lib.getTimer() - prevFrame;
		prevFrame = Lib.getTimer();
		
		game.step();
	}
}
package com.subfty.angrymonument;
import com.subfty.sub.display.ImgSprite;
import nme.Assets;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.TouchEvent;
import nme.media.Sound;

/**
 * ...
 * @author Filip Loster
 */

class Game extends Sprite{

	private var actorsContainter:Sprite;
	
	public var background:Background;
	var player:Player;
	public var archOverlord:ArchOverlord;
	private var endGame:Sound;
	
	private var tStep:Float;
	
	public function new(p:Sprite) {
		super();
		
		p.addChild(this);		
		
		background = new Background(this);
		background.tilesContainer.addEventListener(MouseEvent.MOUSE_DOWN, onTap);
		background.tilesContainer.addEventListener(TouchEvent.TOUCH_BEGIN, onTap);
		
		actorsContainter = new Sprite();
		actorsContainter.mouseChildren = false;
		actorsContainter.mouseEnabled = false;
		actorsContainter.x = background.tilesContainer.x;
		actorsContainter.y = background.tilesContainer.y;
		
		this.addChild(actorsContainter);
		
		endGame = Assets.getSound("sound/endGame.wav");
		
		player = new Player(actorsContainter);
		archOverlord = new ArchOverlord(actorsContainter, player);
	}
	
	public function newGame() {
		Main.GAME_STARTED = true;
		archOverlord.newGame();
		player.newGame();
		Main.setPoints(0);
		Main.gtime = 1000 * 43;
		tStep = 1000;
	}
	
	
	
	public function step() {
		background.step();
		player.step();
		archOverlord.step();
		
		for (i in 1...actorsContainter.numChildren) {
			for (j in 0...i) {
				var k = i - j;
				if (actorsContainter.getChildAt(k).y < actorsContainter.getChildAt(k - 1).y)
					actorsContainter.swapChildrenAt(k, k-1);
			}
		}
		
		if (Main.GAME_STARTED) {
			tStep -= Main.delta;
			if (tStep < 0) {
				tStep += 1000;
				Main.setTime(Main.gtime - 1000);
				if (Main.gtime < 0) {
					Main.setTime(0);
					Main.killGame();
					endGame.play();
				}
			}
		}
	}
	
  //TAP ACTIONS
	private function onTap(e:Event) {
		var tile:ImgSprite = cast(e.target, ImgSprite);
		
		player.jumpTo(Math.round(tile.x / Background.getTileWidth()),
					  Math.round(tile.y / Background.getTileHeight()));
	}
}
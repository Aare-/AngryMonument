package com.subfty.angrymonument;
import com.subfty.sub.display.ImgSprite;
import nme.Assets;
import nme.display.Sprite;
import nme.media.Sound;

/**
 * ...
 * @author Filip Loster
 */

class Player extends Sprite{

	public var image(default, null):ImgSprite;
	
	public var tile_x(default, null):Int;
	public var tile_y(default, null):Int;
	
	private var target_tile_x:Int;
	private var target_tile_y:Int;
	
  //JUMP DATA
	private var JUMP_TIME:Int = 1000;
	public var jumping(default, null):Bool = false;
	private var jumpPhase:Float = 0;
	
  //SOUNDS
	private var jumpSound:Sound;
	private var hitSound:Sound;
	private var missSound:Sound;
	
	public var playHitSound:Bool = false;
	public var playMissSound:Bool = false;
	
	private var tCounter:Int = 0;
	
	public function new(p:Sprite){
		super();
		
		p.addChild(this);
		
		image = new ImgSprite(this);
		image.loadImage("img/monument.png");
		
		image.width = Background.getTileWidth();
		image.height = 39.0 / 26.0 * Background.getTileWidth();
		
		image.x = -image.width / 2;
		image.y = -image.height;
		
		jumpSound = Assets.getSound("sound/jump.wav");
		hitSound = Assets.getSound("sound/hit.wav");
		missSound = Assets.getSound("sound/miss.wav");
		newGame();
		step();
	}
	
	public function newGame() {
		tile_x = Math.floor(Background.BOARD_WIDTH / 2);
		tile_y = Math.floor(Background.BOARD_HEIGHT / 2);
	}
	
	public function step() {
		if (jumping) {
			jumpPhase += Main.delta;
			var alpha:Float = jumpPhase / JUMP_TIME;
				
			
			var tlX:Float = Background.getTileWidth() * tile_x;
			var tgX:Float = Background.getTileWidth() * target_tile_x;
			x = tlX + (tgX - tlX) * alpha + image.width/2;
			
			var tlY:Float = Background.getTileHeight() * tile_y-image.height+Background.getTileHeight()*(9.0/11.0);
			var tgY:Float = Background.getTileHeight() * target_tile_y-image.height+Background.getTileHeight()*(9.0/11.0);
			y = tlY + (tgY - tlY) * alpha - Math.sin(Math.PI*alpha) * 500+image.height;
			
			if (alpha >= 1) {
				tile_x = target_tile_x;
				tile_y = target_tile_y;
				jumping = false;
				step();
			}
			
			playMissSound = true;
		}else{		
			x = Background.getTileWidth() * tile_x+ image.width/2;
			y = Background.getTileHeight() * tile_y-image.height+Background.getTileHeight()*(9.0/11.0)+image.height;
		
			if (playHitSound) {
				playHitSound = false;
				playMissSound = false;
				hitSound.play();
			}
			if (playMissSound) {
				playMissSound = false;
				missSound.play();
			}
		}
		
		
	}
	
	public function jumpTo(targetX:Int, targetY:Int) {
		if (jumping) return;
		if (!Main.GAME_STARTED){
			if(--tCounter < 0){
				Main.game.newGame();
				tCounter = 2;
			}
		}
		
		jumpSound.play();
		target_tile_x = targetX;
		target_tile_y = targetY;
		jumping = true;
		jumpPhase = 0;
	}
}
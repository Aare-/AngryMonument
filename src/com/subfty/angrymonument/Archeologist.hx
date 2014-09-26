package com.subfty.angrymonument;
import com.subfty.sub.display.ImgSprite;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author Filip Loster
 */

class Archeologist extends Sprite{

	private static var FRONT:BitmapData;
	private static var BACK:BitmapData;
	private static var LEFT:BitmapData;
	private static var RIGHT:BitmapData;
	
	/* 
	 * 0 - front 
	 * 1 - back 
	 * 2 - left 
	 * 3 - right
	 * */
	//public var direction(default, _set_direction):Int;
	
	/*private function _set_direction(inVal:Int):Int {
		direction = inVal;
		switch(inVal) {
			case 0: image.loadBitmapData(FRONT);
			case 1: image.loadBitmapData(BACK);
			case 2: image.loadBitmapData(RIGHT);
			case 3: image.loadBitmapData(LEFT);		
		}
		
		return inVal;
	}*/
	
	private var image:ImgSprite;
	private var speed:Float;
	
	private var mov:Float = 0;
	
	private var moveSide:Float;
	private var playerRef:Player;
	
	public function new(p:Sprite, pl:Player) {
		super();
		
		this.playerRef = pl;
		p.addChild(this);
		
		if (FRONT == null) {
			FRONT = Assets.getBitmapData("img/dude_front.png");
		}
		
		image = new ImgSprite(this);
		image.loadBitmapData(FRONT);
		image.width = Background.getTileWidth() * 0.8;
		image.height = 18 / 17 * image.width;
		
		image.x = -image.width / 2;
		image.y = -image.height;
		this.visible = false;
	}

	public function init() {
		this.visible = true;
		
		//direction = 0;
		
		
		this.x = Math.floor(Math.random() * Background.BOARD_WIDTH) * Background.getTileWidth() + 
				 Background.getTileWidth()*0.5;
		this.y = -20;
		speed = 0.05 + 0.13 * Math.random();
		mov = Math.random();
		
		moveSide = 0.0;
		
		step();
	}
	
	private function setDirection(direction:Int) {
		switch(direction) {
			case 0: image.loadBitmapData(FRONT);
			case 1: image.loadBitmapData(BACK);
			case 2: image.loadBitmapData(RIGHT);
			case 3: image.loadBitmapData(LEFT);		
		}
		
	}
	
	public function kill() {
		this.visible = false;
	}
	private function splash() {
		this.visible = false;
		playerRef.playHitSound = true;
		
		Main.setPoints(Main.points + 100);
	}
	
	public function step() {
		if (this.y < 0)
			this.alpha = 1 - ( -this.y / 50.0);
		else
			this.alpha = 1;
		
	  //AVOIDING BLOCK
		if (moveSide > 0.0) {
			var ammount:Float = Main.delta * 0.5;
			if (ammount > moveSide) ammount = moveSide;
			moveSide -= ammount;
			this.x += ammount;
			
			if (moveSide <= 0.0)
				moveSide = 0.0;
		}
		if (moveSide < 0.0) {
			var ammount:Float = -Main.delta * 0.5;
			if (ammount < moveSide) ammount = moveSide;
			moveSide -= ammount;
			this.x += ammount;
			
			if (moveSide >= 0.0)
				moveSide = 0.0;
		}
		
			
		this.y += Main.delta * speed;
		
		var a:Float = mov / 300.0;
		
		rotation =  Math.sin(Math.PI * 2 * a) * 10.0;
		
		mov += Main.delta;
		if (mov > 300.0)
			mov = 0;
		
		if (this.y - image.height > Background.getTileHeight() * Background.BOARD_HEIGHT) {
			kill();
		}
		
	  //AVOIDING BLOCK
		if (this.x > playerRef.tile_x * Background.getTileWidth() && 
		    this.x < (playerRef.tile_x+1) * Background.getTileWidth() &&
			this.y < playerRef.tile_y * Background.getTileHeight() && 
		    this.y > (playerRef.tile_y-1) * Background.getTileHeight() &&
			moveSide == 0.0 &&
			!playerRef.jumping) {
			if (x > Background.getTileWidth()*(Background.BOARD_WIDTH-1)) 
				moveSide = -Background.getTileWidth();
			else if (x < Background.getTileWidth()) 
				moveSide = Background.getTileWidth();
			else{
				moveSide = Background.getTileWidth();
				if (Math.random() > 0.5)
					moveSide *= -1;
			}
		}
		
	  //SPLASHING
		if (!playerRef.jumping &&
			this.x > playerRef.tile_x * Background.getTileWidth() && 
		    this.x < (playerRef.tile_x+1) * Background.getTileWidth() &&
			this.y < (playerRef.tile_y+1) * Background.getTileHeight() && 
		    this.y > (playerRef.tile_y) * Background.getTileHeight()) 
				splash();
			
		
	}
}
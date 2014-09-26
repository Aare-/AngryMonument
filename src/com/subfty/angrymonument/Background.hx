package com.subfty.angrymonument;
import com.subfty.sub.display.ImgSprite;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.EventDispatcher;
import nme.events.MouseEvent;
import nme.events.TouchEvent;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;

/**
 * ...
 * @author Filip Loster
 */

class Background extends Sprite{
  //GAME SETTINGS
  	//Q10
	public static var BOARD_WIDTH:Int = 6;
	public static var BOARD_HEIGHT:Int = 8;
  	
	//public static var BOARD_WIDTH:Int = 8;
	//public static var BOARD_HEIGHT:Int = 7;
	

	public static var BOARD_MARGINS:Float = 0;
	public static var BOARD_MARGIN_BOTTOM:Float = 0;
	
	var bgBitmap:BitmapData;
	public var tilesContainer:Sprite;
	var tiles:Array<ImgSprite>;
	
	var doorsBitmap:BitmapData;
	var doorsContainer:Sprite;
	var doors:Array<ImgSprite>;
	
	//TEXT STUFF
	public var scoreVal:TextField;
	public var timeVal:TextField;
	var font:Font;
	var format:TextFormat;
	
	public function new(p:Sprite) {
		super();
		
		p.addChild(this);
	
		tiles = new Array<ImgSprite>();
		
		var blackFiller:Sprite = new Sprite();
		blackFiller.graphics.clear();
		blackFiller.graphics.beginFill(0x000000);
		blackFiller.graphics.drawRect(0, 0, Main.STAGE_W * 1.5, 400);
		blackFiller.x = -Main.STAGE_W * 0.25;
		blackFiller.y = Main.STAGE_H - getTileHeight() * BOARD_HEIGHT - BOARD_MARGIN_BOTTOM-400;
		this.addChild(blackFiller);
		
		
		bgBitmap = Assets.getBitmapData("img/bg_tile.png");
		tilesContainer = new Sprite();
		tilesContainer.x = BOARD_MARGINS;
		tilesContainer.y = Main.STAGE_H - getTileHeight() * BOARD_HEIGHT - BOARD_MARGIN_BOTTOM;
		this.addChild(tilesContainer);
		
		for (i in 0...BOARD_HEIGHT) {
			for (j in 0...BOARD_WIDTH) {
				var img:ImgSprite = new ImgSprite(tilesContainer);
				img.loadBitmapData(bgBitmap);
				
				img.width = getTileWidth()*1.001;
				img.height = getTileHeight() * 1.002;
				img.x = j * getTileWidth();
				img.y = i * getTileHeight();
			}
		}
		
		doorsBitmap = Assets.getBitmapData("img/doors.png");
		doorsContainer = new Sprite();
		doorsContainer.x = tilesContainer.x;
		doorsContainer.y = tilesContainer.y - getDoorHeight();
		this.addChild(doorsContainer);
		
		for (i in 0...BOARD_WIDTH) {
			var img:ImgSprite = new ImgSprite(doorsContainer);
			img.loadBitmapData(doorsBitmap);
			
			img.width = getTileWidth()*1.001;
			img.height = getDoorHeight()*1.001;
			img.x = getTileWidth() * i;
			img.y = 0;
		}
		
		font = Assets.getFont("fonts/8bitlim.ttf");
		format = new TextFormat(font.fontName, 10, 0xffffff);
		
		scoreVal = new TextField();
		scoreVal.defaultTextFormat = format;
		scoreVal.x = 20;
		scoreVal.y = 0;
		scoreVal.width = 512;
		scoreVal.height = 200;
		scoreVal.text = "0pts";
		scoreVal.alpha = 0.7;
		scoreVal.selectable = false;
		scoreVal.embedFonts = true;
		scoreVal.scaleX = scoreVal.scaleY = 8;
		scoreVal.mouseEnabled = false;
		this.addChild(scoreVal);
		
		timeVal = new TextField();
		timeVal.defaultTextFormat = format;
		//timeVal.x = 950;
		//Q10
		timeVal.x = Main.STAGE_W*0.7;
		timeVal.y = 0;
		timeVal.width = 512;
		timeVal.height = 200;
		timeVal.text = "0.00";
		timeVal.alpha = 0.7;
		timeVal.selectable = false;
		timeVal.embedFonts = true;
		timeVal.scaleX = timeVal.scaleY = 8;
		timeVal.mouseEnabled = false;
		this.addChild(timeVal);
	}
	
  //GETTERS AND SETTERS
	public static inline function getTileWidth():Float {
		return Math.floor((Main.STAGE_W - BOARD_MARGINS * 2) / BOARD_WIDTH);
	}
	public static inline function getTileHeight():Float {
		return 11.0 / 26.0 * Math.floor((Main.STAGE_W - BOARD_MARGINS * 2) / BOARD_WIDTH);
	}
	public static inline function getDoorHeight():Float {
		return 33.0 / 26.0 * getTileWidth();
	}
	
	public function step() {
	  //TODO: fade out the blood splaters
	}
}
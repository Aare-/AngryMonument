package com.subfty.sub.display;

import com.subfty.angrymonument.Main;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.Lib;
import nme.events.Event;

/**
 * ...
 * @author Filip Loster
 */

class ImgSprite extends Sprite{
	public var image : Bitmap;
	
	public function new(parent:Sprite) {
		super();
		
		parent.addChild(this);
	}
	
  //INIT FUNCTIONS
	public function loadBitmapData(data:BitmapData):Void {
		if (this.image == null){
			this.image = new Bitmap(data);
			this.addChild(image);
			
			return;
		}
			
		this.image.bitmapData = data;
	}
	public function loadBitmap(image:Bitmap):Void {
		this.image = image;
		if (image != null)
			this.addChild(image);
	}
	public function loadImage(image:String):Void {
		loadBitmap(new Bitmap(Assets.getBitmapData(image)));
	}
	
  //SETTERS AND GETTERS
	public function setRect(x:Float, y:Float, width:Float, height:Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
  //HELPERS
	public function setImgOnCenter():Void {
		image.x = -image.width / 2;
		image.y =  -image.height / 2;
	}
}
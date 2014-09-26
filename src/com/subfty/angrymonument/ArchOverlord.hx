package com.subfty.angrymonument;
import nme.display.Sprite;

/**
 * ...
 * @author Filip Loster
 */

class ArchOverlord extends Sprite{

	private var archis:Array<Archeologist>;
	private var p:Sprite;
	
	private var spawnDelay:Float;
	private var playerRef:Player;
	
	public function new(p:Sprite, pl:Player) {
		super();
		
		this.playerRef = pl;
		this.p = p;
		archis = new Array<Archeologist>();
	}
	
	private function spawnNew() {
		for ( i in 0...archis.length)
			if (!archis[i].visible) {
				archis[i].init();
				return;
			}
			
		archis.push(new Archeologist(p, playerRef));
		spawnNew();
	}
	
	public function killAll() {
		for (i in 0...archis.length) 
			if (archis[i].visible)
				archis[i].kill();
	}
	
	public function newGame() {
		for (i in 0 ... archis.length) 
			archis[i].kill();
		spawnDelay = getSpawnDelay();
	}
	
	public function step() {
		if (!Main.GAME_STARTED) return;
		
		for (i in 0 ... archis.length) 
			if (archis[i].visible)
				archis[i].step();
		
		spawnDelay -= Main.delta;
		if (spawnDelay < 0) {
			spawnDelay = getSpawnDelay();
			spawnNew();
		}
	}
	
	private inline function getSpawnDelay():Float {
		return 400.0 + 400.0*Math.random();
	}
}
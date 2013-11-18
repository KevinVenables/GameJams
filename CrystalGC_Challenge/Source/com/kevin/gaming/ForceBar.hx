package com.kevin.gaming;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.Assets;
import nme.geom.Rectangle;
import nme.geom.Point;
/**
 * ...
 * @author Kevin Venables
 */
class ForceBar
{
	var tilesheet : Tilesheet;
	public var force : Int;
	public var position : Point;
	public var startingPosition : Point;
	
	public function new(position : Point) 
	{
		tilesheet = new Tilesheet(Assets.getBitmapData("assets/forceBar.png"));
		tilesheet.addTileRect(new Rectangle(0, 0, 64, 18));
		tilesheet.addTileRect(new Rectangle(0, 18, 8, 18)); // Force = 1
		tilesheet.addTileRect(new Rectangle(0, 18, 16, 18)); // Force = 2
		tilesheet.addTileRect(new Rectangle(0, 18, 24, 18)); // force = 3
		tilesheet.addTileRect(new Rectangle(0, 18, 32, 18)); // yada yada yada
		tilesheet.addTileRect(new Rectangle(0, 18, 40, 18));
		tilesheet.addTileRect(new Rectangle(0, 18, 48, 18));
		tilesheet.addTileRect(new Rectangle(0, 18, 56, 18));
		tilesheet.addTileRect(new Rectangle(0, 18, 64, 18));
		force = 0;
		
		animationTimer = 50; // in ms
		time = 0; //for good measure
		this.position = position;
		startingPosition = position.clone();
		animated = true;
	}
	
	
	public function reset() : Void
	{
		position = startingPosition.clone();
		force = 0;
		animated = true;
	}
	
	public function update ( delta : Float) : Void
	{
		if(Game.gameState == Game.FORCE_CLICK)
			runAnimation(delta);
			
	}
	
	public function render ( graphics : Graphics) : Void
	{
		tilesheet.drawTiles(graphics, [position.x, position.y, 0]);
		if(Game.gameState != Game.BALL_LAUNCH && Game.gameState != Game.BALL_STOP)
			tilesheet.drawTiles(graphics, [position.x, position.y, force]);
	}
	
	private var animationTimer : Float;	
	private var time : Float;
	public var animated : Bool;
	public function runAnimation(delta : Float) : Void
	{
		time = time + delta;
		if (time >= animationTimer)
		{
			time = 0;
			force += 1;
			if (force > 8)
				force = 0;
		}
	}
	
	public function stopAnimation() : Void
	{
		animated = false;
	}
}
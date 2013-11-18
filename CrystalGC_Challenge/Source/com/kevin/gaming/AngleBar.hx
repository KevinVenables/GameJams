package com.kevin.gaming;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.Assets;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Kevin Venables
 */
class AngleBar
{
	var tilesheet : Tilesheet;
	public var position : Point;
	public var angle : Int;
	public var startingPosition : Point;
	public function new(initPos : Point) 
	{
		tilesheet = new Tilesheet(Assets.getBitmapData("assets/angleBar.png"));
		tilesheet.addTileRect(new Rectangle(0, 0, 18, 64));
		tilesheet.addTileRect(new Rectangle(18, 56, 18, 8));
		tilesheet.addTileRect(new Rectangle(18, 48, 18, 16));
		tilesheet.addTileRect(new Rectangle(18, 40, 18, 24));
		tilesheet.addTileRect(new Rectangle(18, 32, 18, 32));
		tilesheet.addTileRect(new Rectangle(18, 24, 18, 40));
		tilesheet.addTileRect(new Rectangle(18, 16, 18, 48));
		tilesheet.addTileRect(new Rectangle(18, 8, 18, 56));
		tilesheet.addTileRect(new Rectangle(18, 0, 18, 64));
		position = new Point();
		angle = 0;
		
		animationTimer = 50; // in ms
		time = 0; //for good measure
		this.position = initPos;
		startingPosition = initPos.clone();
		animated = true;
	}
	
	public function reset() : Void
	{
		position = startingPosition.clone();
		angle = 0;
	}
	
	public function update(delta : Float) : Void
	{
		if (Game.gameState == Game.ANGLE_CLICK)
			runAnimation(delta);
	}
	
	public function render(graphics : Graphics) : Void
	{
		/*
		tilesheet.drawTiles(graphics, Camera.offsetObject(position, 0));
		if(angle > 0 && Game.gameState != Game.BALL_LAUNCH  && Game.gameState != Game.BALL_STOP)
			tilesheet.drawTiles(graphics, [position.x, position.y + (64 - (angle * 8)), angle]);
			*/
		tilesheet.drawTiles(graphics, [position.x, position.y, 0]);
		if(angle > 0 && Game.gameState != Game.BALL_LAUNCH  && Game.gameState != Game.BALL_STOP)
			tilesheet.drawTiles(graphics, [position.x, position.y + (64 - (angle * 8)), angle]);
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
			angle += 1;
			if (angle > 8)
				angle = 0;
		}
	}
	
	public function stopAnimation () : Void
	{
		animated = false;
	}
	
}
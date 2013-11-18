package com.kevin.gaming;

import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.events.KeyboardEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;
import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Ball
{

	public var texture : Tilesheet;
	
	public var position : Point;
	public var weight : Float;
	public var terminalVelocity : Float;
	public static var rect : Rectangle;
	
	//velocity
	public static var velocityX : Float;
	public static var velocityY : Float;
	
	//grabity
	public static var gravity : Float;
	public var isFalling : Bool;
	
	public function new(startingPos : Point) 
	{
		gravity = 0.1;
		position = startingPos;
		terminalVelocity = 21; //m / s
		texture = new Tilesheet(Assets.getBitmapData("assets/shotput.png"));
		texture.addTileRect(new Rectangle(0, 0, 16, 16));
		rect = new Rectangle(position.x, position.y, 16, 16);
		isFalling = true;
		
	}
	
	public function update(game : Game) : Void
	{
		
		if (Game.gameState == Game.BALL_STOP)
		{
			isFalling = false;
			velocityY = 0;
			velocityX = 0;
		}
			
		if (isFalling)
		{
			if(velocityY < terminalVelocity)
				velocityY += gravity * 5;
		}
			
		
		
		if (Game.gameState == Game.BALL_LAUNCH || Game.gameState == Game.BALL_STOP)
			game.moveObjects(new Point(velocityX, velocityY));
	}
	
	
	public function render(graphics : Graphics) : Void
	{
		texture.drawTiles(graphics, [position.x, position.y, 0]);
	}
	
}
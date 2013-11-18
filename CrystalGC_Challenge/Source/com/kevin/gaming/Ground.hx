package com.kevin.gaming;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.geom.Point;
import nme.geom.Rectangle;

import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Ground extends GameObject
{
	public var position : Point;
	public var startingPosition : Point;
	public var texture : Tilesheet;
	public var rect : Rectangle;
	public function new(position : Point) 
	{
		this.position = position;
		startingPosition = position.clone();
		texture = new Tilesheet(Assets.getBitmapData("assets/tar.png"));
		texture.addTileRect(new Rectangle(0, 0, 200, 50));
		rect = new Rectangle(position.x, position.y + 20, 200, 10);
		super();
	}
	public function reset() : Void
	{
		position = startingPosition.clone();
	}
	override public function update(delta:Float):Void 
	{
		if (rect.intersects(Ball.rect))
		{
			Game.gameState = Game.BALL_STOP;
		}
		rect = new Rectangle(position.x, position.y + 20, rect.width, rect.height);
		super.update(delta);
	}
	
	override public function render(graphics:Graphics):Void 
	{
		texture.drawTiles(graphics, [position.x, position.y, 0]);
		super.render(graphics);
	}
	
}
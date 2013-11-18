package com.kevin.gaming;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.geom.Point;
import nme.Assets;
import nme.geom.Rectangle;

/**
 * ...
 * @author Kevin Venables
 */
class Player extends GameObject
{
	public var angleBar : AngleBar;
	public var forceBar : ForceBar;
	public var tilesheet : Tilesheet;
	public var position : Point;
	public var startingPosition : Point;
	public var rect : Rectangle;
	
	public function new(initPos : Point) 
	{
		position = initPos;
		startingPosition = initPos.clone();
		tilesheet = new Tilesheet(Assets.getBitmapData("assets/player.png"));
		tilesheet.addTileRect(new Rectangle(0, 0, 32, 32));
		rect = new Rectangle(position.x, position.y, 32, 32);
		angleBar = new AngleBar(new Point(position.x - 35, position.y - 18));
		forceBar = new ForceBar(new Point(position.x - 18, position.y - 40));
		super();
	}
	
	override public function update(delta:Float):Void 
	{
		angleBar.update(delta);
		forceBar.update(delta);
		super.update(delta);
	}
	
	public function reset() : Void
	{
		position = startingPosition.clone();
		angleBar.reset();
		forceBar.reset();
	}
	
	public function movePlayer(velocity : Point) : Void
	{
		position.x -= velocity.x;
		position.y -= velocity.y;
		angleBar.position.x -= velocity.x;
		angleBar.position.y -= velocity.y;
		forceBar.position.x -= velocity.x;
		forceBar.position.y -= velocity.y;
	}
	
	override public function render(graphics:Graphics):Void 
	{
		tilesheet.drawTiles(graphics, [position.x, position.y, 0]);
		angleBar.render(graphics);
		forceBar.render(graphics);
		super.render(graphics);
	}
	
}
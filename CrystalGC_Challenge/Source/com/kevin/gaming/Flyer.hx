package com.kevin.gaming;
import nme.display.Graphics;
import nme.display.Tilesheet;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Assets;

//import Flyer_Effect;
//import Rainbow_Effect;

/**
 * ...
 * @author Kevin Venables
 */
class Flyer extends GameObject
{
	public var texture : Tilesheet;
	public var position : Point;
	public var rect : Rectangle;
	public var flyer_effect : Flyer_Effect;
	public function new(pos : Point, flyer : Int = 0) 
	{
		position = pos;
		texture = new Tilesheet(Assets.getBitmapData("assets/flyers.png"));
		if (flyer == 0) //rainbow dash
		{
			texture.addTileRect(new Rectangle(0, 0, 32, 32));
			flyer_effect = new Rainbow_Effect();
		}
		else if (flyer == 1)
		{
			texture.addTileRect(new Rectangle(32, 0, 32, 32));
			flyer_effect = new Derpy_Effect();
		}
		
		else if (flyer == 2)
		{
			texture.addTileRect(new Rectangle(64, 0, 32, 32));
			flyer_effect = new Scoot_Effect();
		}
		
		else if ( flyer == 3)
		{
			texture.addTileRect(new Rectangle(96, 0, 32, 32));
			flyer_effect = new Pinkie_Effect();
		}
		
		else if (flyer == 4)
		{
			texture.addTileRect(new Rectangle(0, 32, 32, 32));
			flyer_effect = new Cele_Effect();
		}
		
		else if (flyer == 5)
		{
			texture.addTileRect(new Rectangle(32, 32, 32, 32));
			flyer_effect = new Luna_Effect();
		}
		
		else if (flyer == 6)
		{
			texture.addTileRect(new Rectangle(64, 32, 32, 32));
			flyer_effect = new Apple_Effect();
		}
		
		
		rect = new Rectangle(pos.x, pos.y, 32, 32);
		super();
	}
	
	override public function update(delta:Float):Void 
	{
		rect.x = position.x;
		rect.y = position.y;
		if (Ball.rect.intersects(rect))
		{
			flyer_effect.runEffect();
			Game.headTrauma += 1;
		}
		super.update(delta);
	}
	
	override public function render(graphics:Graphics):Void 
	{
		texture.drawTiles(graphics, [position.x, position.y, 0]);
		super.render(graphics);
	}
	
	public function moveFlyer ( velocity : Point)
	{
		position.x -= velocity.x;
		position.y -= velocity.y;
	}
	
}
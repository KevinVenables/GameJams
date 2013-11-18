package com.kevin.gaming;

import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.display.Tilesheet;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;
import nme.Assets;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.events.MouseEvent;
import nme.ui.Keyboard;
/**
 * ...
 * @author Kevin Venables
 */
class Game extends Sprite
{
	var delta : Float;
	var lastTime : Float;
	var ground : Array<Ground>;
	var ball : Ball;
	var player : Player;
	
	
	public static var background : Tilesheet;
	public static var day : Tilesheet;
	public static var night : Tilesheet;
	
	
	//gamestate
	public static var FORCE_CLICK : Int = 0;
	public static var ANGLE_CLICK : Int = 1;
	public static var BALL_LAUNCH : Int = 2;
	public static var BALL_STOP : Int = 3;
	public static var gameState : Int = 0; //zero by default
	
	public static var headTrauma : Int = 0;
	public static var distance : Float = 0;
	var headText : TextField;
	var distText : TextField;
	
	var bestTrauma : Int;
	var bestTraumaText : TextField;
	
	var bestDistance : Float;
	var bestDistanceText : TextField;
	
	//flyers
	var flyers : Array<Flyer>;
	static var numOfFlyers : Int = 100;
	public static var uniMoveY : Int = 0;
	
	//debug text
	//var debug : TextField;
	
	public function new() 
	{
		initialize();
		super();
	}
	private function initialize ():Void 
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		
		headText = new TextField();
		headText.x = 200;
		headText.textColor = 0xFF0000;
		headText.text = "Head Trauma : " +  Std.string(headTrauma);
		Lib.current.stage.addChild(headText);
		distText = new TextField();
		distText.x = 100;
		distText.textColor = 0xFF0000;
		distText.text = "Distance : " + Std.string(distance);
		Lib.current.stage.addChild(distText);
		
		bestDistance = 0;
		bestDistanceText = new TextField();
		bestDistanceText.textColor = 0xFF0000;
		bestDistanceText.x = 400;
		bestDistanceText.width = 200;
		//bestDistanceText.multiline = true;
		bestDistanceText.text = "Best Distance : " + Std.string(bestDistance);
		Lib.current.stage.addChild(bestDistanceText);
		
		bestTrauma = 0;
		bestTraumaText = new TextField();
		bestDistanceText.textColor = 0xFF0000;
		bestTraumaText.x = 600;
		bestTraumaText.textColor = 0xFF0000;
		bestTraumaText.text = "Best Trauma : " + Std.string(bestTrauma);
		Lib.current.stage.addChild(bestTraumaText);
		
		day = new Tilesheet(Assets.getBitmapData("assets/day.png"));
		day.addTileRect(new Rectangle(0, 0, 800, 600));
		night = new Tilesheet(Assets.getBitmapData("assets/night.png"));
		night.addTileRect(new Rectangle(0, 0, 800, 600));
		
		background = day; //day by default, can be night
		
		
		/*
		debug = new TextField();
		debug.text = "helloworld";
		Lib.current.stage.addChild(debug);*/
		
		ball = new Ball(new Point(400, 300));
		ground = new Array<Ground>();
		setupGround();
		player = new Player(new Point(368, 300));
		launchBall();
		delta = 0;
		lastTime = 0;
		
		generateFlyer();
	}
	
	function generateFlyer() : Void
	{
		flyers = new Array<Flyer> ();
		var x_base : Int = 0;
		for (n in 0...numOfFlyers)
		{
			var random : Int = Std.random(7);
			
			if (random == 0 || random == 1 || random == 4 || random == 5) //dashie, derpy
			{
				flyers.push(new Flyer(new Point(Std.random(1000) + x_base, Std.random(1000) - 700), random));
			}
			else if (random == 2) //scoots
			{
				flyers.push(new Flyer(new Point(Std.random(1000) + x_base + 500, 280), random));
			}
			else if (random == 3 || random == 6) //
			{
				flyers.push(new Flyer(new Point(Std.random(1000) + x_base + 500, 300), random));
			}
			
			x_base += 100;
		}
		
	}
	
	function setupGround() : Void
	{
		for (n in 0...100)
		{
			ground.push(new Ground(new Point(200 * n, 332)));
		}
	}
	
	public function update(e : Event = null) : Void
	{
		delta = Lib.getTimer() - lastTime;
		lastTime = Lib.getTimer();
		player.update(delta);
		
		for (flyer in flyers)
		{
			flyer.update(delta);
		}
		
		for (obj in ground)
		{
			obj.update(delta);
		}
		ball.update(this);
		
		
		if (player.position.x > 1000) 
			reset();
		
		
		//debugUpdate();
		//update score
		headText.text = "Head Trauma : " +  Std.string(headTrauma);
		distText.text = "Distance : " + Std.string(distance);		
		bestTraumaText.text = "Best Trauma : " + Std.string(bestTrauma);
		bestDistanceText.text = "Best Distance : " + Std.string(bestDistance);
		
		render();
		
	}
	
	public function moveObjects(velocity : Point ) : Void
	{
		//moveGround
		distance += velocity.x;
		moveGround(new Point(velocity.x, velocity.y - uniMoveY));
		player.movePlayer(new Point(velocity.x, velocity.y - uniMoveY));
		for (flyer in flyers)
		{
			flyer.moveFlyer(new Point(velocity.x, velocity.y - uniMoveY));
		}
		
		uniMoveY = 0;
	}
	
	function moveGround(velocity : Point) : Void
	{
		for (obj in ground)
		{
			obj.position.x -= velocity.x;
			obj.position.y -= velocity.y;
		}
	}
	
	public function render() : Void
	{
		graphics.clear();
		background.drawTiles(graphics, [0, 0, 0]);
		for (obj in ground)
		{
			obj.render(graphics);
		}
		ball.render(graphics);
		player.render(graphics);

		
		for (flyer in flyers)
		{
			flyer.render(graphics);
		}
		
	}
	
	static var VEL_MULT : Float = 10;
	
	function launchBall() : Void
	{
		
		Ball.velocityX = (player.forceBar.force) * (player.angleBar.angle) / 8 * VEL_MULT;
		Ball.velocityY = (player.forceBar.force) / (player.angleBar.angle)  * -1 * VEL_MULT;	

		
	}
	
	function onMouseClick(e:MouseEvent) : Void
	{
		if (player.rect.contains(e.localX, e.localY))
		{
			if (gameState == FORCE_CLICK)
			{
				gameState = ANGLE_CLICK;
			}
			else if (gameState == ANGLE_CLICK)
			{
				gameState = BALL_LAUNCH;
				launchBall();
			}
		}
		if (gameState == BALL_STOP)
		{
			//Lib.close();
			reset();
		}
	}
	
	function reset() : Void
	{
		gameState = FORCE_CLICK;
		//reset
		player.reset();
		Ball.velocityX = 0;
		Ball.velocityY = 0;
		ball.isFalling = true;
		//reset ground
		for (obj in ground)
		{
			obj.reset();
		}
		
		generateFlyer();
		if (distance > bestDistance)
		{
			bestDistance = distance;
		}
		if (headTrauma > bestTrauma)
		{
			bestTrauma = headTrauma;
		}
		distance = 0;
		headTrauma = 0;
		//generate new flyers
		
	}
	//update debug
	/*
	function debugUpdate() : Void
	{
		debug.text = "Ball :  " 
			+ Std.string(ball.position.x) + ", " + Std.string(ball.position.y)
			//+ //"\nForce : " + Std.string(forceBar.force)
			//+ "\nAngle : " + Std.string(angleBar.angle)
			+ "\nGamestate : " + Std.string(gameState);
			
	}
	*/
	
}
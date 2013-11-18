package com.kevin.gaming;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Cele_Effect extends Flyer_Effect
{
	var sound : Sound;
	public function new() 
	{
		sound = Assets.getSound("assets/sounds/rainbow_Hit.mp3");
		super();
	}
	
	override public function runEffect():Void 
	{
		Ball.velocityY = Ball.velocityY * -1;
		Game.background = Game.day;
		Game.uniMoveY = 10;
		sound.play();
		super.runEffect();
	}
}
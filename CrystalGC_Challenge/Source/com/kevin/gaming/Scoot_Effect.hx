package com.kevin.gaming;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Scoot_Effect extends Flyer_Effect
{
	var sound:Sound;
	public function new() 
	{
		sound = Assets.getSound("assets/sounds/rainbow_Hit.mp3");
		super();
	}
	
	override public function runEffect():Void 
	{
		Ball.velocityX = Ball.velocityX * 2;
		Game.uniMoveY = 10;
		sound.play();
		super.runEffect();
	}
}
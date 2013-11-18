package com.kevin.gaming;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Pinkie_Effect extends Flyer_Effect
{
	var sound:Sound;
	public function new() 
	{
		sound = Assets.getSound("assets/sounds/party.mp3");
		super();
	}
	
	override public function runEffect():Void 
	{
		Ball.velocityY = Ball.velocityY * -2;
		Game.uniMoveY = 20;
		sound.play();
		super.runEffect();
	}
	
	
}
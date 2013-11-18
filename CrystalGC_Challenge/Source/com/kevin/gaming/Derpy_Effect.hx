package com.kevin.gaming;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Kevin Venables
 */
class Derpy_Effect extends Flyer_Effect
{
	var sound : Sound;
	public function new() 
	{
		sound = Assets.getSound("assets/sounds/derpy.mp3");
		super();
	}
	
	override public function runEffect():Void 
	{
		Ball.velocityX = Ball.velocityX * -1;
		Game.uniMoveY = 10;
		sound.play();
		super.runEffect();
	}
	
	
}
package;

import flixel.FlxSprite;

class CoolFrame extends FlxSprite
{
	public function new(x:Float, y:Float, ?scaleX:Float = 3, ?scaleY:Float = 3)
	{
		super(x, y);

		// Loads the basic UI graphic.
		loadGraphic("assets/images/ui/basicFrame.png");

		// Sets the scale.
		scale.set(scaleX, scaleY);

		// Updates Sprite Hitbox.
		updateHitbox();
	}
}

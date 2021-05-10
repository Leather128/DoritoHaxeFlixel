package;

import flixel.FlxG;
import flixel.FlxSprite;

class CoolButton extends FlxSprite
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

	dynamic public function onClick()
	{
		// Default Function If Non Was Set
		trace("Default Click Function.");
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.mouse.justPressed)
		{
			// Player Clicked Their Left Mouse Button
			trace("MOUSE CLICK!");

			if (FlxG.mouse.x >= x && FlxG.mouse.x < x + (scale.x * 16) + 1)
			{
				// Player's Mouse is in the X Range of the button.
				trace("MOUSE IS IN THE X BARRIER!");

				if (FlxG.mouse.y >= y && FlxG.mouse.y < x + (scale.y * 16) + 1)
				{
					// Player's mouse is on the button, so call the click function!
					trace("MOUSE IS IN THE Y BARRIER!");
					onClick();
				}
			}
		}
	}
}

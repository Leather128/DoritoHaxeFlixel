package;

import flixel.FlxSprite;

class BackgroundImage extends FlxSprite
{
	public function new()
	{
		super(x, y);

		// Loads the background image
		loadGraphic("assets/images/ui/background.png");

		// Centers to the screen
		screenCenter();
	}
}

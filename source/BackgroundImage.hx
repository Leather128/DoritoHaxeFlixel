package;

import flixel.FlxSprite;

class BackgroundImage extends FlxSprite
{
	public function new()
	{
		super(x, y);

		// Loads the background image
		loadGraphic(AssetPaths.background__png);

		// Centers to the screen
		screenCenter();
	}
}

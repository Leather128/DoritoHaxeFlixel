package;

import flixel.FlxSprite;

class Dorito extends FlxSprite
{
	public function new(x:Float, y:Float, ?centered:Bool = false, ?colorVar = 0xFF7F00)
	{
		super(x, y);

		// Loads the Dorito graphic (taken from the OG Program)
		loadGraphic("assets/images/dorito.png");

		// If centered, it centers it.
		if (centered == true)
		{
			screenCenter();
		}

		// Basic Settings
		antialiasing = true;

		// Color! Because that sure matters.
		color = colorVar;
	}
}

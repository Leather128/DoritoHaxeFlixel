package;

import flixel.FlxSprite;

class Dorito extends FlxSprite
{
	public function new(x:Float, y:Float, ?centered:Bool = false, ?colorVar = 0xFF7F00)
	{
		super(x, y);

		loadGraphic("assets/images/dorito.png");

		if (centered == true)
		{
			screenCenter();
		}

		color = colorVar;
	}
}

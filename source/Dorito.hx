package;

import flixel.FlxSprite;

class Dorito extends FlxSprite
{
	public var doritoType:String = "orange";

	public function new(x:Float, y:Float, ?centered:Bool = false)
	{
		super(x, y);

		loadNewDorito(doritoType, 1);

		// If centered, it centers it.
		if (centered == true)
		{
			screenCenter();
		}

		// Basic Settings
		antialiasing = true;
	}

	public function loadNewDorito(type:String, scaleVar:Float, ?antiAl:Bool = true)
	{
		doritoType = type;

		// Loads the Dorito graphic
		loadGraphic("assets/images/doritos/dorito-" + doritoType + ".png");
		scale.set(scaleVar, scaleVar);
		antialiasing = antiAl;
		updateHitbox();
	}
}

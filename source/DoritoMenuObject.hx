package;

import flixel.FlxG;
import flixel.FlxSprite;

class DoritoMenuObject extends FlxSprite
{
	public var objType:String = "orange";
	public var defaultY:Float = 0;

	public function new(x:Float, y:Float, scaleVar:Float = 1, ?doritoType:String = "orange", ?antiAl:Bool = true, ?centered:Bool = false)
	{
		super(x, y);

		objType = doritoType;
		defaultY = y;
		loadNewDorito(doritoType);

		// If centered, it centers it.
		if (centered == true)
		{
			screenCenter();
		}

		// Basic Settings
		antialiasing = antiAl;

		scale.set(scaleVar, scaleVar);
		updateHitbox();
	}

	public function loadNewDorito(type:String)
	{
		// Loads the Dorito graphic
		loadGraphic("assets/images/doritos/dorito-" + type + ".png");
	}
}

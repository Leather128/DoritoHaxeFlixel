package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class DoritoUI extends FlxTypedGroup<FlxSprite>
{
	// DATA ARRAYS
	public var doritos:Array<Dynamic> = [
		// IT GOES LIKE THIS: [TypeInImageNameLol, ScaleInUI, Antialiasing, ScaleInGame, NameOnDiscordRPC, TimePrice]
		["orange", 0.1, true, 1, "Original Orange", 5],
		["plain", 0.1, true, 1, "Plain White", 5],
		["pixel", 2, false, 19, "Pixelated Orange", 15]
	];
	public var doritoSprites:Array<DoritoMenuObject> = [];

	var doritoFrame = new CoolFrame(45, 100, 8, 15);

	public function new()
	{
		super();

		add(doritoFrame);

		// MENU STUFF LOL
		for (i in 0...doritos.length)
		{
			trace("----");
			trace("TYPE: " + doritos[i][0]);
			trace("SCALE: " + doritos[i][1]);
			trace("ANTIALISASED: " + doritos[i][2]);

			var newObject = new DoritoMenuObject(70, 120 + (30 * i), doritos[i][1], doritos[i][0], doritos[i][2]);
			doritoSprites.insert(doritoSprites.length, newObject);
			add(newObject);

			var newObjectPriceTag = new FlxText(95, 120 + (30 * i), 1000, "Price: " + doritos[i][5], 8);
			newObjectPriceTag.wordWrap = false;
			newObjectPriceTag.borderColor = FlxColor.BLACK;
			newObjectPriceTag.borderStyle = FlxTextBorderStyle.OUTLINE;
			newObjectPriceTag.borderSize = 1;
			add(newObjectPriceTag);
		}
	}
}

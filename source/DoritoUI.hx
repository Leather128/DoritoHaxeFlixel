package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using flixel.util.FlxSpriteUtil;

class DoritoUI extends FlxTypedGroup<FlxSprite>
{
	// DATA ARRAYS
	var doritoData:Array<String> = Assets.getText("assets/data/dorito-shop.txt").split('\n');

	public var doritoShopData:Array<DoritoShopData> = [];
	public var doritos:Array<Dynamic> = [];

	public var doritoSprites:Array<DoritoMenuObject> = [];
	public var prices:Array<CoolText> = [];

	public var doritoFrame = new CoolFrame(45, 100, 7, 100);

	public function new()
	{
		super();

		add(doritoFrame);

		// loops through the raw text data
		for (v in doritoData)
		{
			// splits it into an array
			var doritoDataArray = v.split(":");

			// default antialiasing value
			var doritoBoolData = true;

			// if its not antialiased set it to NOT be
			if (doritoDataArray[2] == "false")
				doritoBoolData = false;

			// create some new shop data for us to use! :) (not PlayState.hx since idk it just don't let me do that)
			var doritoDataObject = new DoritoShopData(doritoDataArray[0], Std.parseFloat(doritoDataArray[1]), doritoBoolData,
				Std.parseFloat(doritoDataArray[3]), doritoDataArray[4], Std.parseInt(doritoDataArray[5]));

			// push our new shop data to the bottom of the shop data list!
			doritoShopData.push(doritoDataObject);
		}

		// MENU STUFF LOL
		for (i in 0...doritoShopData.length)
		{
			// debugging lol
			trace("----");
			trace("TYPE: " + doritoShopData[i].valueName);
			trace("SCALE: " + doritoShopData[i].shopSize);
			trace("ANTIALISASED: " + doritoShopData[i].antialias);

			// creates the new menu object
			var newObject = new DoritoMenuObject(70, 120 + (30 * i), doritoShopData[i].shopSize, doritoShopData[i].valueName, doritoShopData[i].antialias);

			// pushes it to the end of the sprite group
			doritoSprites.push(newObject);

			// adds it to the screen
			add(newObject);

			// price tag for the dorito
			var newObjectPriceTag = new CoolText(95, 120 + (30 * i), 1000, "Price: " + doritoShopData[i].timePrice, 8);

			// setup text
			newObjectPriceTag.wordWrap = false;
			newObjectPriceTag.borderColor = FlxColor.BLACK;
			newObjectPriceTag.borderStyle = FlxTextBorderStyle.OUTLINE;
			newObjectPriceTag.borderSize = 1;

			// pushes the new price tag to back of prices array / group
			prices.push(newObjectPriceTag);

			// adds pricing to the screen
			add(newObjectPriceTag);

			// pushes the dorito shop data to the doritos array so that it can be handled in PlayState.hx
			// i wish it could just push the DoritoShopData but i dont wanna figure out what an abstract
			// is rn so i aint doing that
			doritos.push([
				doritoShopData[i].valueName,
				doritoShopData[i].shopSize,
				doritoShopData[i].antialias,
				doritoShopData[i].gameSize,
				doritoShopData[i].realName,
				doritoShopData[i].timePrice
			]);
		}
	}
}

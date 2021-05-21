package;

import flixel.FlxSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUITabMenu;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using flixel.util.FlxSpriteUtil;

class DoritoUI extends FlxTypedGroup<FlxSprite>
{
	// DATA ARRAYS
	var doritoData:Array<String> = Assets.getText(AssetPaths.dorito_shop__txt).split('\n');
	var UI_box = new FlxUITabMenu(null, [], false);

	public var doritoShopData:Array<DoritoShopData> = [];
	public var doritos:Array<Dynamic> = [];

	var doritoPageData:Array<Dynamic> = [];

	public var doritoSprites:Array<DoritoMenuObject> = [];
	public var prices:Array<FlxText> = [];

	var backButton:FlxUIButton;
	var fowardButton:FlxUIButton;
	var pageText:FlxText;

	var currentPage:Int = 0;

	public function new()
	{
		super();

		// SHOP BACKGROUND THING
		UI_box.resize(112, 300);
		UI_box.x = 45;
		UI_box.y = 100;
		add(UI_box);

		// BACK PAGE BUTTON
		backButton = new FlxUIButton(50, 380, "<", backPage);
		backButton.setLabelFormat(null, 8, FlxColor.BLACK, FlxTextAlign.CENTER);
		backButton.resize(15, 15);

		// FOWARD PAGE BUTTON
		fowardButton = new FlxUIButton(138, 380, ">", fowardPage);
		fowardButton.setLabelFormat(null, 8, FlxColor.BLACK, FlxTextAlign.CENTER);
		fowardButton.resize(15, 15);

		// page text
		pageText = new FlxText(75, 380, 1000, "Page " + Std.string(currentPage + 1) + "/" + Std.string(doritoPageData.length + 1), 8);

		// setup page text
		pageText.wordWrap = false;
		pageText.borderColor = FlxColor.BLACK;
		pageText.borderStyle = FlxTextBorderStyle.OUTLINE;
		pageText.borderSize = 1;

		// ADDING PAGE BUTTONS
		add(backButton);
		add(fowardButton);
		add(pageText);

		// loops through the raw text data
		var currentLoopPage:Array<DoritoShopData> = [];

		for (i in 0...doritoData.length)
		{
			var v = doritoData[i];

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

			// fills up the current loop page until its full, then
			if (currentLoopPage.length <= 7)
			{
				currentLoopPage.push(doritoDataObject);

				if (doritoData[i + 1] == null)
				{
					// we know there is no more data then
					doritoPageData.push(currentLoopPage);
					currentLoopPage = [];
				}
			}
			else
			{
				doritoPageData.push(currentLoopPage);
				currentLoopPage = [];
				currentLoopPage.push(doritoDataObject);
			}
		}

		updatePageText();
		updateDoritoPage();
	}

	function updatePageText()
	{
		pageText.text = "Page " + Std.string(currentPage + 1) + "/" + Std.string(doritoPageData.length);
	}

	function updateDoritoPage()
	{
		for (v in doritoSprites)
		{
			remove(v);
		}

		for (v in prices)
		{
			remove(v);
		}

		// MENU STUFF LOL
		for (i in 0...doritoPageData[currentPage].length)
		{
			// creates the new menu object
			var newObject = new DoritoMenuObject(70, 120 + (30 * i), doritoPageData[currentPage][i].shopSize, doritoPageData[currentPage][i].valueName,
				doritoPageData[currentPage][i].antialias);

			// pushes it to the end of the sprite group
			doritoSprites.push(newObject);

			// adds it to the screen
			add(newObject);

			// price tag for the dorito
			var newObjectPriceTag = new FlxText(95, 120 + (30 * i), 1000, "Price: " + doritoPageData[currentPage][i].timePrice, 8);

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
				doritoPageData[currentPage][i].valueName,
				doritoPageData[currentPage][i].shopSize,
				doritoPageData[currentPage][i].antialias,
				doritoPageData[currentPage][i].gameSize,
				doritoPageData[currentPage][i].realName,
				doritoPageData[currentPage][i].timePrice
			]);
		}
	}

	function backPage()
	{
		// code to move back a page in the shop
		if (currentPage >= 1)
		{
			currentPage -= 1;
			updatePageText();
			updateDoritoPage();
		}
	}

	function fowardPage()
	{
		// code to move foward a page in the shop
		if (currentPage < doritoPageData.length - 1)
		{
			currentPage += 1;
			updatePageText();
			updateDoritoPage();
		}
	}
}

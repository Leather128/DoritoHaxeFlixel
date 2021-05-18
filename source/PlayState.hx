package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

#if windows
import Discord.DiscordClient;
#end

class PlayState extends FlxState
{
	// VARIABLE DATA STUFF
	var plain:Bool = false;

	public static var seconds:Float = 0;

	var doritoName:String = "Original Orange";
	var doritoType:String = "orange";
	var doritoSize:Float = 1.0;
	var doritoAnti:Bool = true;

	// COOL CLASSES
	var secondTimer = new FlxTimer();

	var timeText = new FlxText(250, 70, 1000, "Time: 0", 16);
	var dorito = new Dorito(0, 0, true);

	// MENU OBJECTS
	var ui = new DoritoUI();

	// NEW TITLE STATE OBJECT
	var newTitle:TitleState;

	// Background Image
	var background = new BackgroundImage();

	override public function create()
	{
		// adds the background image
		add(background);

		// Tweens into the scene
		FlxG.camera.fade(FlxColor.BLACK, 0.5, true, null, true);

		// Binds the save file to the game
		FlxG.save.bind("DoritoTest");

		// Adds the DoritoUI class (aka the ui lol) into the game screen
		add(ui);

		// idk what this does but ik it's needed to be here
		super.create();

		// adds the time text to da screen
		add(timeText);

		// if the player has seconds data (OLD COMMIT VERSION)
		if (FlxG.save.data.seconds != null)
		{
			// then load it!
			seconds = FlxG.save.data.seconds;
		}

		// if the player has dorito type data (SLIGHTLY NEWER OLD COMMIT)
		if (FlxG.save.data.doritoType != null)
		{
			doritoType = FlxG.save.data.doritoType;
			doritoName = FlxG.save.data.doritoName;
		}

		// if the player has dorito size data (THIS VERSION OR NEWER LOL)
		if (FlxG.save.data.doritoSize != null)
		{
			doritoSize = FlxG.save.data.doritoSize;
		}

		// if the player has dorito size data (THIS VERSION OR NEWER LOL)
		if (FlxG.save.data.doritoAnti != null)
		{
			doritoAnti = FlxG.save.data.doritoAnti;
		}

		// update time text if data got loaded
		timeText.text = "Time: " + seconds;

		// Starts the infinite timer.
		secondTimer.start(1, onTimer, 0);

		// adds dorito to the screen
		add(dorito);

		// loads seperate dorito image (if it's loaded from the save data)
		dorito.loadNewDorito(doritoType, doritoSize, doritoAnti);
	}

	public function onTimer(Timer:FlxTimer)
	{
		// Updates seconds variable, and the text showing the seconds count.
		seconds += 1;
		timeText.text = "Time: " + seconds;
		timeText.color = FlxColor.WHITE;

		#if windows
		DiscordClient.changePresence("Wasting Time", seconds + " seconds wasted! Dorito type: " + doritoName, null);
		#end

		// SAVE DATA
		FlxG.save.data.seconds = seconds;
		FlxG.save.flush();
	}

	function switchBackToTitle()
	{
		// SAVE DATA
		FlxG.save.data.seconds = seconds;
		FlxG.save.data.doritoType = doritoType;
		FlxG.save.data.doritoName = doritoName;
		FlxG.save.data.doritoSize = doritoSize;
		FlxG.save.data.doritoAnti = doritoAnti;
		FlxG.save.flush();

		FlxG.switchState(newTitle);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// changes dorito sprites based on the scroll wheel
		for (v in ui.doritoSprites)
		{
			if (!((v.y + FlxG.mouse.wheel * 5) > v.defaultY))
			{
				v.y += FlxG.mouse.wheel * 5;

				// also moves the shop frame slower than doritos so MORE ROOM YAY
				ui.doritoFrame.y += FlxG.mouse.wheel;
			}
		}

		// moves price tags based on scroll wheel too (coolness)
		for (v in ui.prices)
		{
			if (!((v.y + FlxG.mouse.wheel * 5) > v.defaultY))
			{
				v.y += FlxG.mouse.wheel * 5;
			}
		}

		// Fullscreen Key Press
		if (FlxG.keys.justPressed.F11 || (FlxG.keys.justPressed.ALT && FlxG.keys.justPressed.ENTER))
			FlxG.fullscreen = !FlxG.fullscreen;

		if (FlxG.keys.justPressed.ESCAPE)
		{
			newTitle = new TitleState();
			newTitle.isEscaped = true;

			// Tweens into the scene
			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, switchBackToTitle);
		}

		// if u just clicked
		if (FlxG.mouse.justPressed)
		{
			// loop through the dorito shop sprites
			for (i in 0...ui.doritoSprites.length)
			{
				// sets v to the current selected sprite (cuz smaller code go br)
				var v = ui.doritoSprites[i];

				if (FlxG.mouse.x >= v.x && FlxG.mouse.x < v.x + (v.width + 1))
				{
					// Player's Mouse is in the X Range of the button.
					trace("MOUSE IS IN THE X BARRIER!");

					if (FlxG.mouse.y >= v.y && FlxG.mouse.y < v.y + (v.height + 1))
					{
						// Player's mouse is on the button, so call the click function!
						trace("MOUSE IS IN THE Y BARRIER!");

						// if you are clicking on da button and have enough seconds wasted then
						if (seconds >= ui.doritos[i][5])
						{
							// subtract your seconds
							seconds -= ui.doritos[i][5];

							// change the time text to show you've LOST TIME!
							timeText.text = "Time: " + seconds;
							timeText.color = FlxColor.RED;

							// sets some values for Discord RPC + actual dorito
							doritoName = ui.doritos[i][4];
							doritoType = v.objType;
							doritoSize = ui.doritos[i][3];
							doritoAnti = ui.doritos[i][2];

							// loads new dorito sprite
							dorito.loadNewDorito(doritoType, doritoSize, doritoAnti);

							#if windows
							// if your on windows (not html5) then change discord rich presence thing lol
							DiscordClient.changePresence("Wasting Time", seconds + " seconds wasted! Dorito type: " + doritoName, null);
							#end

							// SAVE DATA
							FlxG.save.data.seconds = seconds;
							FlxG.save.data.doritoType = doritoType;
							FlxG.save.data.doritoName = doritoName;
							FlxG.save.data.doritoSize = doritoSize;
							FlxG.save.data.doritoAnti = doritoAnti;
							FlxG.save.flush();
						}
					}
				}
			}
		}
	}
}

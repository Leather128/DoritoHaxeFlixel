package;

import Discord.DiscordClient;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

using StringTools;

class PlayState extends FlxState
{
	// VARIABLE DATA STUFF
	var plain:Bool = false;

	public static var seconds:Float = 0;

	var doritoName:String = "Original Orange";
	var doritoType:String = "orange";

	// COOL CLASSES
	var secondTimer = new FlxTimer();

	var timeText = new FlxText(250, 70, 1000, "Time: 0", 16);
	var dorito = new Dorito(0, 0, true);

	// MENU OBJECTS
	var ui = new DoritoUI();

	override public function create()
	{
		FlxG.save.bind("DoritoTest");
		add(ui);
		super.create();
		add(timeText);

		seconds = FlxG.save.data.seconds;
		timeText.text = "Time: " + seconds;

		// Starts the inf timer.
		secondTimer.start(1, onTimer, 0);
		add(dorito);
	}

	public function onTimer(Timer:FlxTimer)
	{
		// Updates seconds variable, and the text showing the seconds count.
		seconds += 1;
		timeText.text = "Time: " + seconds;
		timeText.color = FlxColor.WHITE;
		DiscordClient.changePresence("Wasting Time.", seconds + " seconds wasted! Dorito type: " + doritoName, null);

		FlxG.save.data.seconds = seconds;
		FlxG.save.flush();
	}

	public function changeType(type:String, seconds:Float, ?typeName:String = "Dorito")
	{
		if (seconds >= 5)
		{
			seconds -= 5;

			timeText.text = "Time: " + seconds;
			timeText.color = FlxColor.RED;

			doritoName = typeName;
			doritoType = type;

			dorito.loadNewDorito(doritoType, 1);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (v in ui.doritoSprites)
		{
			if (!((v.y + FlxG.mouse.wheel * 5) > v.defaultY))
			{
				v.y += FlxG.mouse.wheel * 5;
				ui.doritoFrame.y += FlxG.mouse.wheel;
			}
		}

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

		if (FlxG.mouse.justPressed)
		{
			for (i in 0...ui.doritoSprites.length)
			{
				var v = ui.doritoSprites[i];

				// Player Clicked Their Left Mouse Button
				trace("MOUSE CLICK!");

				if (FlxG.mouse.x >= v.x && FlxG.mouse.x < v.x + (v.width + 1))
				{
					// Player's Mouse is in the X Range of the button.
					trace("MOUSE IS IN THE X BARRIER!");

					if (FlxG.mouse.y >= v.y && FlxG.mouse.y < v.y + (v.height + 1))
					{
						// Player's mouse is on the button, so call the click function!
						trace("MOUSE IS IN THE Y BARRIER!");
						if (seconds >= ui.doritos[i][5])
						{
							seconds -= ui.doritos[i][5];

							timeText.text = "Time: " + seconds;
							timeText.color = FlxColor.RED;

							doritoName = ui.doritos[i][4];
							doritoType = v.objType;

							dorito.loadNewDorito(doritoType, ui.doritos[i][3], ui.doritos[i][2]);
						}
					}
				}
			}
		}
	}
}

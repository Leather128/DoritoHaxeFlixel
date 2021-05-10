package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	// VARIABLE DATA STUFF
	var plain:Bool = false;
	var seconds = 0;

	// COOL CLASSES
	var secondTimer = new FlxTimer();
	var timeText = new FlxText(50, 70, 1000, "Time: 0", 16);
	var dorito = new Dorito(0, 0, true);
	var newButton = new CoolButton(50, 50, 5, 1);
	var newButtonText = new FlxText(55, 50, 5 * 16, "Color Change", 8);

	override public function create()
	{
		super.create();

		// New Button Setup
		newButton.color = 0xFFAA00;

		// Custom Function
		newButton.onClick = function test()
		{
			doritoChange();
		}

		// New Button Text Setup
		newButtonText.wordWrap = false;
		newButtonText.borderColor = FlxColor.BLACK;
		newButtonText.borderStyle = FlxTextBorderStyle.OUTLINE;
		newButtonText.borderSize = 1;

		// Adds all sprites and stuff into the thing.
		add(dorito);
		add(newButton);
		add(newButtonText);
		add(timeText);

		// Starts the inf timer.
		secondTimer.start(1, onTimer, 0);
	}

	public function onTimer(Timer:FlxTimer)
	{
		// Updates seconds variable, and the text showing the seconds count.
		seconds += 1;
		timeText.text = "Time: " + seconds;
		timeText.color = FlxColor.WHITE;
	}

	public function doritoChange()
	{
		// If you have wasted enough time, you can change colors!
		if (seconds >= 5)
		{
			// Minuses your seconds wasted.
			seconds -= 5;

			// Updates the text showing seconds.
			timeText.text = "Time: " + seconds;
			timeText.color = FlxColor.RED;

			// If it's not plain white, make it plain white, if plain white, make it orange again!
			if (plain == false)
			{
				trace("WHITE");
				plain = true;
				dorito.color = 0xFFFFFF;
			}
			else
			{
				trace("ORANGE");
				plain = false;
				dorito.color = 0xFF7F00;
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Fullscreen Key Press
		if (FlxG.keys.justPressed.F11 || (FlxG.keys.justPressed.ALT && FlxG.keys.justPressed.ENTER))
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}

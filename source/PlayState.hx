package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var plain:Bool = false;
	var sprite = new FlxSprite();
	var secondTimer = new FlxTimer();
	var seconds = 0;
	var timeText = new FlxText(50, 70, 1000, "Time: 0", 16);

	override public function create()
	{
		super.create();

		sprite.loadGraphic("assets/images/dorito.png");
		sprite.screenCenter();
		sprite.antialiasing = false;
		sprite.color = 0xFF7F00;
		add(sprite);

		var button = new FlxButton(50, 50, "Change Type", doritoChange);
		add(button);

		add(timeText);

		secondTimer.start(1, onTimer, 0);
	}

	public function onTimer(Timer:FlxTimer)
	{
		seconds += 1;
		timeText.text = "Time: " + seconds;
	}

	public function doritoChange()
	{
		if (plain == false)
		{
			trace("WHITE");
			plain = true;
			sprite.color = 0xFFFFFF;
		}
		else
		{
			trace("ORANGE");
			plain = false;
			sprite.color = 0xFF7F00;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var plain:Bool = false;
	var sprite = new FlxSprite();

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

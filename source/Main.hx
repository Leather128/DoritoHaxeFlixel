package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		// makes the state lol
		addChild(new FlxGame(640, 480, PlayState));
	}
}

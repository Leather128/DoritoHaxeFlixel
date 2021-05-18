package;

#if windows
import Discord.DiscordClient;
#end
import flixel.FlxGame;
import lime.app.Application;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		// makes the game appear lol
		addChild(new FlxGame(640, 480, TitleState));

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});
		#end
	}
}

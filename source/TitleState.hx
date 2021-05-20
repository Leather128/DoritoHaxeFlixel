package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
#if windows
import Discord.DiscordClient;
#end

class TitleState extends FlxState
{
	public var titleText = new FlxText(0, 0, 0, "Dorito.exe", 48);
	public var doritoIcon = new Dorito(0, 0, true);
	public var playButton:FlxUIButton;
	public var isEscaped = false;

	// Background Image
	var background = new BackgroundImage();

	override public function create():Void
	{
		// discord rpc message
		#if windows
		DiscordClient.changePresence("In The Main Menu", "0 seconds wasted! Dorito type: Waiting to start...", null);
		#end

		// adds the background image
		add(background);

		if (isEscaped)
		{
			// Tweens into the scene (FROM PlayState.hx)
			FlxG.camera.fade(FlxColor.BLACK, 0.5, true, null, true);
		}

		// Creates the play button
		playButton = new FlxUIButton(0, 0, "Play", fadePlay, true, false, FlxColor.ORANGE);
		playButton.setLabelFormat(null, 25, FlxColor.WHITE, FlxTextAlign.CENTER);
		playButton.resize(200, 55);

		// Centers Title Screen Text
		titleText.screenCenter();

		// Offsets it for the logo
		titleText.y -= 175;

		// Centers the play button
		playButton.screenCenter();

		// Offsets the play button for da logo
		playButton.y += 150;

		// Adds Stuff to the screen
		add(titleText);
		add(doritoIcon);
		add(playButton);
	}

	function fadePlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, play);
	}

	function play()
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		// call super to update the core state class
		super.update(elapsed);

		// Fullscreen Key Press (FROM PlayState.hx)
		if (FlxG.keys.justPressed.F11 || (FlxG.keys.justPressed.ALT && FlxG.keys.justPressed.ENTER))
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}

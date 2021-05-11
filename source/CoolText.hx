package;

import flixel.text.FlxText;

class CoolText extends FlxText
{
	public var defaultY:Float = 0;

	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, ?EmbeddedFont:Bool = true)
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		defaultY = y;
	}
}

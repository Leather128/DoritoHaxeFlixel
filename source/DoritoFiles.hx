package;

using StringTools;

class DoritoFiles
{
	public static function getAssetThing(path:String, type:String, ?extension:String = "png")
	{
		return "assets/" + type + "/" + path + "." + extension;
	}
}

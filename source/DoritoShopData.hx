package;

class DoritoShopData
{
	public var valueName = "orange";
	public var shopSize = 0.1;
	public var antialias = true;
	public var gameSize = 1.0;
	public var realName = "Original Orange";
	public var timePrice = 5.0;

	public function new(value_Name:String, shop_Size:Float, _antialias:Bool, game_Size:Float, real_Name:String, time_Price:Float)
	{
		this.valueName = value_Name;
		this.shopSize = shop_Size;
		this.antialias = _antialias;
		this.gameSize = game_Size;
		this.realName = real_Name;
		this.timePrice = time_Price;
	}
}

package utils;

/**
 * ...
 * @author 
 */
class Random
{
	private var _seed:Float;
	
	public var seed(get, set):Float;
	
	public function new(seed:Float)
	{
		_seed = seed;
	}
	
	public function get_seed(): Float
	{
		return _seed;
	}

	public function set_seed(seed:Float):Float
	{
		_seed = seed;
		return _seed;
	}
	
	public function nextNumber():Float
	{
		_seed = (_seed * 9301 + 49297) % 233280;
		return _seed / 233280.0;
	}
}

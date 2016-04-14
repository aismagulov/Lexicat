package ;

/**
 * ...
 * @author 
 */
class Constants
{
	public static var W:Float;
	public static var H:Float;

#if android
	public static var BACK_KEY:Float = 1073742094;
#elseif flash
	public static var BACK_KEY:Float = 27;
#end

	public function new() 
	{
		
	}
	
}
package ;
import openfl.text.TextFormatAlign;
import openfl.Assets;
import openfl.text.Font;
import openfl.text.TextFormat;

/**
 * ...
 * @author 
 */
class TextFormats
{
	static public var cardTextFormat:TextFormat;
	static public var buttonTextFormat:TextFormat;
	static public var font:Font;
	static public var boldFontName:String;

	public static function Init() 
	{
		boldFontName = "Vollkorn Bold";
		font = Assets.getFont("font/vollkorn.bold.ttf");
		
		buttonTextFormat = new TextFormat(boldFontName, 48, 0xffffff);
		buttonTextFormat.align = TextFormatAlign.CENTER;
		
		cardTextFormat = new TextFormat(boldFontName, 20, 0x64351b);
		cardTextFormat.align = TextFormatAlign.CENTER;
		cardTextFormat.leading = 2;
		
		
	}
	
}
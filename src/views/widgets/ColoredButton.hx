package views.widgets;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.text.TextFormat;
import ru.stablex.ui.skins.Slice3;
import ru.stablex.ui.widgets.Button;

/**
 * ...
 * @author 
 */
class ColoredButton extends Button
{
	var skinBmd:BitmapData;
	var skinPressedBmd:BitmapData;

	public function new(colorName:String = "")
	{
		super();
		
		var skinName:String = "";
		
		switch (colorName)
		{
			case "orange":
				skinName = "img/skins/btnOrange.png";
			case "green":
				skinName = "img/skins/btnGreen.png";
			case "violet":
				skinName = "img/skins/btnViolet.png";
			default:
				skinName = "img/skins/btnBlue.png";
		}
		
		var skinPressName = skinName.split(".")[0] + "D.png";
		skinBmd = Assets.getBitmapData(skinName);
		skinPressedBmd = Assets.getBitmapData(skinPressName);
	}
	
	override public function onInitialize():Void 
	{
		super.onInitialize();
		
		var btnSkin = new Slice3();
		btnSkin.bitmapData = skinBmd;
		skin = btnSkin;
		
		var btnPressedSkin = new Slice3();
		btnPressedSkin.bitmapData = skinPressedBmd;
		skinPressed = btnPressedSkin;
		
		//this.embedFonts = true;
		label.embedFonts = true;
		
        this.format.size = 36;
        this.format.color = 0xFFFFFF;
        this.format.font = TextFormats.boldFontName;
		
		//format = TextFormats.buttonTextFormat;
		//label.defaultTextFormat = TextFormats.buttonTextFormat;
		
		applySkin();
	}
}
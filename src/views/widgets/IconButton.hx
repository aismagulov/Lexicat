package views.widgets;

import openfl.Assets;
import openfl.display.BitmapData;
import ru.stablex.ui.skins.Slice3;
import ru.stablex.ui.widgets.Button;

/**
 * ...
 * @author 
 */
class IconButton extends Button
{
	var skinBmd:BitmapData;
	var skinPressedBmd:BitmapData;

	public function new(imageName:String = "")
	{
		super();
		
		var skinName:String = "";
		
		switch (imageName)
		{
			case "settings":
				skinName = "img/skins/settingsBtn.png";
			case "switch":
				skinName = "img/skins/switchBtn.png";
			default:
				skinName = "img/skins/switchBtn.png";
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
				
		format = TextFormats.buttonTextFormat;
		label.defaultTextFormat = TextFormats.buttonTextFormat;
		
		applySkin();
	}
	
}
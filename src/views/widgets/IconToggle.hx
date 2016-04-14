package views.widgets;

import openfl.Assets;
import ru.stablex.ui.skins.Img;
import ru.stablex.ui.widgets.Toggle;

/**
 * ...
 * @author 
 */
class IconToggle extends Toggle
{

	public function new() 
	{
		super();
		
	}
	
	override public function onInitialize():Void 
	{
		super.onInitialize();
		
		var pressed = new Img();
		pressed.bitmapData = Assets.getBitmapData("img/skins/markBtnD.png");
		
		var idle = new Img();
		idle.bitmapData = Assets.getBitmapData("img/skins/markBtn.png");
		
		skin = idle;
		skinPressed = pressed;
		states.get("up").skin = idle;
		states.get("down").skin = pressed;
	}
}
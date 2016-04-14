package views;

import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.text.TextField;

/**
 * ...
 * @author 
 */
class Preloader extends NMEPreloader
{

	public function new() 
	{
		super();
		
		var rect = new Shape();
		rect.graphics.beginFill(0xdedede, 1);
		rect.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		addChild(rect);
		
		var tf = new TextField();
		tf.textColor = 0xffffff;
		tf.text = "Lexicat";
		addChild(tf);
	}
	
}
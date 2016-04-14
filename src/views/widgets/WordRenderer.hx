package views.widgets;

import openfl.text.TextField;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */
class WordRenderer extends Widget
{
	var tf:Text;

	public function new(w1:String, w2:String) 
	{
		super();
		
		this.skin = new Paint();
		cast(this.skin, Paint).color  = 0x999999;
		cast(this.skin, Paint).border = 1;
		//this.onInitialize();
		//this.onCreate();
		
		
		tf = UIBuilder.create(Text, { w: 200, h: 40, text: w1 + " - " + w2, format: 
										{ 
											align:"left", 
											size:24, 
											color: 0xffffff,
											font:TextFormats.boldFontName
										}} );
										
		tf.mouseEnabled = false;
		
		trace("tf.text " + tf.text);
		
		tf.text = w1 + " -> " + w2;
		
		this.addChild(tf);
	}
	
}
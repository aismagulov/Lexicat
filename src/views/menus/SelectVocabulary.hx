package views.menus;

import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Options;
import views.widgets.ColoredButton;

/**
 * ...
 * @author 
 */
class SelectVocabulary extends Menu
{
	var selectBtn:Button;
	var vocList:Options;
	
	public function new() 
	{
		super();
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		vocList = UIBuilder.create(Options, { w: 200, h: 100, left: 50, top:50 } );
		vocList.options = [["Deutsch -> Russian", "vocDeRu"], ["English -> Russian", "vocEnRu"]];
		
		selectBtn = UIBuilder.create(ColoredButton, { w: 200, h: 100, left: 50, top:300, text:"Select" } );
		listen(selectBtn, onSelectClick);
		
		layout.addChild(vocList);
		layout.addChild(selectBtn);
	}
	
	private function onSelectClick(btn:InteractiveObject):Void 
	{
		menuManager.SetMenu(MenuTypes.MAIN);
	}
	
}
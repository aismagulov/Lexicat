package views.menus ;
import openfl.Assets;
import openfl.display.InteractiveObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import ru.stablex.ui.layouts.Column;
import ru.stablex.ui.skins.Slice3;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Widget;
import views.widgets.ColoredButton;

/**
 * ...
 * @author 
 */
class MainMenu extends Menu
{
	var selectBtn:Button;
	var startBtn:Button;
	var helpBtn:Button;
	var continueBtn:Button;
	var buttons:Array<Button>;
	
	public function new() 
	{
		super();
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		var container = UIBuilder.create(Widget);
		
		selectBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text: "Dictionaries" } );
		startBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text: "Start" });
		continueBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Continue" } );
		helpBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Help" } );
		
		listen(startBtn, onStartClick);
		listen(selectBtn, onSelectClick);
		listen(continueBtn, onContinueClick);
		listen(helpBtn, onHelpClick);
		
		buttons = [selectBtn, startBtn, continueBtn, helpBtn];
		for (i in 0...buttons.length) 
		{
			buttons[i].y = 105 * i;
		}
		
		container.addChild(selectBtn);
		container.addChild(startBtn);
		container.addChild(continueBtn);
		container.addChild(helpBtn);
		
		container.x = Constants.W / 2 - container.width / 2;
		container.y = Constants.H / 2 - container.height / 2;
		layout.addChild(container);
		
		var bg = new Shape();
		bg.graphics.beginFill(0x000000, 0.4);
		bg.graphics.drawRect(0, 0, Constants.W, container.height + 100);
		bg.y = container.y - 50;
		layout.addChildAt(bg, layout.getChildIndex(container));
		
	}
	
	private function onHelpClick(btn:InteractiveObject):Void 
	{
		//menuManager.SetMenu(MenuTypes.OPTIONS);
	}
	
	override public function Init() 
	{
		super.Init();
		
		verticalFloat(buttons);
	}
	
	private function onContinueClick(btn:InteractiveObject):Void 
	{
		
	}
	
	private function onSelectClick(btn:InteractiveObject):Void 
	{
		menuManager.SetMenu(MenuTypes.SELECT);
	}
	
	private function onStartClick(btn:InteractiveObject):Void 
	{
		menuManager.SetMenu(MenuTypes.START);
	}
}
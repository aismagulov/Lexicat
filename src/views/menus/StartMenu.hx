package views.menus;

import openfl.Assets;
import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.Widget;
import views.widgets.ColoredButton;
import views.widgets.IconButton;

/**
 * ...
 * @author 
 */
class StartMenu extends Menu
{
	var switchBtn:Button;
	var startBtn:Button;
	var backBtn:Button;
	var tf:Text;
	var buttons:Array<Button>;
	
	public function new() 
	{
		super();
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		var container = UIBuilder.create(Widget);
		
		tf = UIBuilder.create(Text, { w: 200, h: 100, top:50, text:"Text"
										,format: 
										{ 
											align:"center", 
											size:48, 
											font:TextFormats.boldFontName
										}} );
		
		tf.x = Constants.W / 2;
		
		backBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Back" } );
		startBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Start" } );
		switchBtn = UIBuilder.create(IconButton, { w: 80, h: 80 }, ["switch"] );
		
		buttons = [switchBtn, startBtn, backBtn];
		for (i in 0...buttons.length) 
		{
			buttons[i].x = -buttons[i].width / 2;
			buttons[i].y = 105 * i;
		}
		
		listen(backBtn, onBackClick);
		listen(startBtn, onStartClick);
		listen(switchBtn, onSwitchClick);
				
		layout.addChild(tf);
		container.addChild(backBtn);
		container.addChild(startBtn);
		container.addChild(switchBtn);
		
		container.x = Constants.W / 2;
		container.y = Constants.H / 2 - container.height / 2;
		layout.addChild(container);
	}
	
	function onSwitchClick(btn:InteractiveObject) 
	{
		mainController.SwitchDirection();
		updateDirectionText();
	}
	
	override public function Init() 
	{
		super.Init();
		
		verticalFloat(buttons);
		
		updateDirectionText();
	}
	
	function updateDirectionText() 
	{
		if (model.mainModel.forward)
			tf.text = model.mainModel.selectedVocabulary.language1 + " -> " + model.mainModel.selectedVocabulary.language2;
		else
			tf.text = model.mainModel.selectedVocabulary.language2 + " -> " + model.mainModel.selectedVocabulary.language1;
	}
	
	override function onKeyDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Constants.BACK_KEY)
		{
			menuManager.SetMenu(MenuTypes.MAIN);
		}
	}
	
	function onStartClick(btn:InteractiveObject) 
	{
		menuManager.SetMenu(MenuTypes.GAME);
	}
	
	private function onBackClick(btn:InteractiveObject):Void 
	{
		menuManager.SetMenu(MenuTypes.MAIN);
	}
	
	override public function Clear() 
	{
		super.Clear();
		
		this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
}
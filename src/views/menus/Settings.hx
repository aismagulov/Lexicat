package views.menus;
import motion.Actuate;
import openfl.display.InteractiveObject;
import openfl.events.MouseEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Widget;
import views.widgets.ColoredButton;

/**
 * ...
 * @author 
 */
class Settings extends Menu
{
	var backBtn:Button;
	var clearMarksBtn:Button;
	var shuffleWordsBtn:Button;
	var shuffleCardsBtn:Button;
	var mainBtn:Button;
	var buttons:Array<Button>;
	
	public function new() 
	{
		super();
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		var container = UIBuilder.create(Widget);
		
		clearMarksBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Clear marks" } );
		shuffleWordsBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Shuffle words" } );
		shuffleCardsBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Shuffle cards" } );
		backBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Back" } );
		mainBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, text:"Main Menu" } );
		
		listen(backBtn, onBackClick);
		listen(clearMarksBtn, onClearMarksClick);
		listen(shuffleCardsBtn, onShuffleCardsClick);
		listen(shuffleWordsBtn, onShuffleWordsClick);
		listen(mainBtn, onMainClick);
		
		buttons = [clearMarksBtn, shuffleWordsBtn, shuffleCardsBtn, backBtn, mainBtn];
		for (i in 0...buttons.length) 
		{
			buttons[i].y = 105 * i;
		}
		
		container.addChild(shuffleCardsBtn);
		container.addChild(shuffleWordsBtn);
		container.addChild(clearMarksBtn);
		container.addChild(backBtn);
		container.addChild(mainBtn);
		
		container.x = Constants.W / 2 - container.width / 2;
		container.y = Constants.H / 2 - container.height / 2;
		layout.addChild(container);
	}
	
	override public function Init() 
	{
		super.Init();
		
		verticalFloat(buttons);
	}
	
	function onShuffleCardsClick(btn:InteractiveObject) 
	{
		model.gameModel.cardsSeed = Math.floor(Math.random() * 2000000);
		menuManager.SetMenu(MenuTypes.GAME);
	}
	
	function onShuffleWordsClick(btn:InteractiveObject) 
	{
		model.gameModel.wordsSeed = Math.floor(Math.random() * 2000000);
		model.gameModel.markedCards = [];
		menuManager.SetMenu(MenuTypes.GAME);
	}
	
	function onClearMarksClick(btn:InteractiveObject)
	{
		model.gameModel.markedCards = [];
		menuManager.SetMenu(MenuTypes.GAME);
	}
	
	function onMainClick(btn:InteractiveObject) 
	{
		menuManager.SetMenu(MenuTypes.MAIN);
	}
	
	private function onBackClick(btn:InteractiveObject):Void 
	{
		menuManager.SetMenu(MenuTypes.GAME);
	}
}
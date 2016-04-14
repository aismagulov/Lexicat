package views.menus;
import controller.GameController;
import controller.MainController;
import model.Model;
import openfl.display.Sprite;
import openfl.Lib;
import views.menus.GameView;

/**
 * ...
 * @author 
 */
class MenuManager
{
	var scene:Sprite;
	var menus:Map<String, Menu> = new Map<String, Menu>();
	var model:Model;
	var mainController:MainController;
	var gameController:GameController;
	var currentMenu:Menu;
	
	public function new(container:Sprite, model:Model, mainController:MainController, gameController:GameController) 
	{
		this.gameController = gameController;
		this.mainController = mainController;
		this.model = model;
		scene = container;
		
		menus.set(MenuTypes.OPTIONS, generateMenu(MenuTypes.OPTIONS));
		menus.set(MenuTypes.MAIN, generateMenu(MenuTypes.MAIN));
		menus.set(MenuTypes.START, generateMenu(MenuTypes.START));
		menus.set(MenuTypes.SELECT, generateMenu(MenuTypes.SELECT));
	}
	
	public function SetMenu(menuType:String)
	{
		if (currentMenu != null)
			currentMenu.Clear();
		
		scene.removeChildren();
		
		var nextMenu:Menu;
		if (menus.get(menuType) == null)
			menus.set(menuType, generateMenu(menuType));
		
		if (menuType == MenuTypes.GAME)
			gameController.Init();
		
		nextMenu = menus.get(menuType);
		currentMenu = nextMenu;
		nextMenu.Init();
		scene.addChild(nextMenu);
	}
	
	function generateMenu(menuType:String):Menu
	{
		var output:Menu = null;
		
		switch (menuType)
		{
			case MenuTypes.MAIN:
				output = new MainMenu();
			case MenuTypes.GAME:
				output = new GameView(gameController);
			case MenuTypes.SELECT:
				//output = new SelectVocabulary();
				output = new EnterWords();
			case MenuTypes.START:
				output = new StartMenu();
			case MenuTypes.OPTIONS:
				output = new Settings();
		}
		
		output.setManager(this);
		output.model = model;
		output.mainController = mainController;
		return output;
	}
	
}
package ;
import controller.GameController;
import controller.MainController;
import flash.display.Sprite;
import haxe.Json;
import model.Model;
import model.vo.Entry;
import model.vo.VocabularySet;
import openfl.Assets;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.system.System;
import views.menus.MenuManager;
import views.menus.MenuTypes;

/**
 * ...
 * @author 
 */
class App extends Sprite
{
	var thisStage:Stage;
	var mainLayer:Sprite;
	var model:Model;
	
	var gameController:GameController;
	var mainController:MainController;
	
	
	public function new() 
	{
		super();
		
		thisStage = Lib.current.stage;
		
		mainLayer = new Sprite();
		thisStage.addChild(mainLayer);
		
		Constants.W = Lib.current.stage.stageWidth;
		Constants.H = Lib.current.stage.stageHeight;
		
		onReady();
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Constants.BACK_KEY)
		{
			//Lib.exit();
			System.exit(0);
		}
	}
	
	function onReady()
	{
		model = new Model();

		TextFormats.Init();
		
		gameController = new GameController(model);
		mainController = new MainController(model);
		
		var menuManager = new MenuManager(mainLayer, model, mainController, gameController);
		menuManager.SetMenu(MenuTypes.MAIN);
		
		var selectedVocabulary = new VocabularySet();
		selectedVocabulary.id = "voc1";
		selectedVocabulary.language1 = "de";
		selectedVocabulary.language2 = "ru";
		
		selectedVocabulary.vocabulary =  [];
		
		var txt = Assets.getText("data/de_ru.json");
		var vocab:Dynamic = Json.parse(txt);
		for (key in Reflect.fields(vocab)) 
		{
			selectedVocabulary.vocabulary.push(new Entry(key, Reflect.getProperty(vocab, key)));
		}
		
		//selectedVocabulary.vocabulary =  [ new Entry("word1", "translate1"), new Entry("word2", "translate2")
					//, new Entry("word3", "translate3") , new Entry("word4", "translate4")
					//, new Entry("word5", "translate5") , new Entry("word6", "translate6")
					//, new Entry("word7", "translate7") , new Entry("word8", "translate8")
					//, new Entry("word9", "translate9") , new Entry("word10", "translate10")
					//, new Entry("word11", "translate11") , new Entry("word12", "translate12")
					//, new Entry("word13", "translate13") , new Entry("word14", "translate14")
					//, new Entry("word15", "translate15") , new Entry("word16", "translate16")
					//, new Entry("word17", "translate17") , new Entry("word18", "translate18")
					//];
					
		mainController.SetVocabulary(selectedVocabulary);
	}
	
}
package model;
import model.GameModel;
import model.MainModel;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author 
 */
class Model
{
	public var gameModel:GameModel;
	public var mainModel:MainModel;
	public var dispatcher:EventDispatcher;
	
	public function new() 
	{
		gameModel = new GameModel(this);
		mainModel = new MainModel(this);
		
		gameModel.currentCardIdx = 0;
		gameModel.markedCards = [];
		gameModel.wordsSeed = Math.floor(Math.random() * 2000000);
		gameModel.cardsSeed = Math.floor(Math.random() * 2000000);
		
		dispatcher = new EventDispatcher();
	}
	
}
package model;
import model.Model;

/**
 * Что можно изменить из настроек игры:
 * сид рандома - перемешать слова
 * текущая карточка
 * отмеченные карточки
 * @author 
 */
class GameModel
{
	var model:Model;
	public var cardsSeed:Int;
	public var wordsSeed:Int;
	public var currentCardIdx:Int;
	public var markedCards:Array<Int>;
	
	public function new(model:Model) 
	{
		this.model = model;
		markedCards = [];
	}
	
}
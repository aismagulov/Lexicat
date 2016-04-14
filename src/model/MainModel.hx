package model;
import model.Model;
import model.vo.VocabularySet;

/**
 * То, что можно изменить из главного меню:
 * 
 * все доступные словари (список можно подгружать, словари можно подгружать)
 * текущий выбранный словарь
 * направление перевода
 * @author 
 */
class MainModel
{
	public var vocabularySets:Array<VocabularySet> = [];
	public var selectedVocabularyId:String;
	public var forward:Bool;
	var model:Model;
	
	public var selectedVocabulary:VocabularySet;
	
	public function new(model:Model) 
	{
		this.model = model;
	}
	
}
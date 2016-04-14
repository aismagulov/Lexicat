package controller;
import controller.GameController;
import model.Model;
import model.vo.VocabularySet;

/**
 * ...
 * @author 
 */
class MainController
{
	var model:Model;
	
	public function new(model:Model) 
	{
		this.model = model;
		
	}
	
	public function SetVocabulary(selectedVocabulary:VocabularySet) 
	{
		model.mainModel.selectedVocabulary = selectedVocabulary;
		model.mainModel.selectedVocabularyId = selectedVocabulary.id;
		model.mainModel.forward = true;
	}
	
	public function SwitchDirection() 
	{
		model.mainModel.forward = !model.mainModel.forward;
		//событие для view
	}
	
}
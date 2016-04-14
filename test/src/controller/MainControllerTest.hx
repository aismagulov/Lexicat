package src.controller;

import controller.MainController;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import model.Model;
import model.vo.VocabularySet;


class MainControllerTest 
{
	var vocabularySet:VocabularySet;
	var mainController:controller.MainController;
	var model:Model;
	/**
	 * Выбирает словарь
	 * Перемешивает колоду
	 * Начинает колоду заново (перемешивает слова, пересоздает карточки)
	 * Запускает игру с неотмеченными или всеми словами, с выбранным языком
	 * Продолжает начатую игру
	 */
	
	public function new() 
	{
		vocabularySet = new VocabularySet();
		
		vocabularySet.id = "voc1";
		vocabularySet.language1 = "lang1";
		vocabularySet.language2 = "lang2";
		vocabularySet.vocabulary = 
					[ { "w1":"word1", "w2":"translate1" }
					, { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" }
					, { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" }
					, { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" }
					, { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" }
					];
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
		model = new Model();
		mainController = new MainController(model);
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	@Test
	public function testExample():Void
	{
		
	}
}
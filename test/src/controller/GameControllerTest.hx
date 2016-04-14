package src.controller;

import controller.GameController;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import model.Model;
import model.vo.Entry;

/**
 * Инициализация словаря
 * Перемешивание словаря
 * Разбивание словаря на карточки по пять слов
 * Отметка карточек
 * Получение неотмеченных карточек
 */
class GameControllerTest 
{
	var gameController:GameController;
	var vocabulary:Array<Entry>;
	var model:Model;
	
	public function new() 
	{
		
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
		gameController = new GameController(model);
		
		vocabulary = [ { "w1":"word1", "w2":"translate1" }
					, { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" }
					, { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" }
					, { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" }
					, { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" }
					];
		
		gameController.InitVocabulary(vocabulary);
	}
	
	@After
	public function tearDown():Void
	{
		gameController.Clear();
		gameController = null;
	}
	
	@Test
	public function testInitVocabulary()
	{
		Assert.areEqual(gameController.vocabulary.length, 9);
	}
	
	@Test
	public function testSetWordsSeed()
	{
		var firstWord:Entry = gameController.vocabulary[0];
		
		gameController.SetWordsSeed(123);
		
		Assert.areNotEqual(gameController.vocabulary[0].w1, firstWord.w1);
		var firstWord:Entry = gameController.vocabulary[0];
		
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } ];
		
		gameController.InitVocabulary(vocabulary);
		gameController.SetWordsSeed(2);
		Assert.areNotEqual(gameController.vocabulary[0].w1, firstWord.w1);
		
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } ];
		
		gameController.InitVocabulary(vocabulary);
		gameController.SetWordsSeed(123);
		Assert.areEqual(gameController.vocabulary[0].w1, firstWord.w1);
	}
	
	@Test
	public function testPrepareCards()
	{
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } , { "w1":"word10", "w2":"translate10" }
					, { "w1":"word11", "w2":"translate11" } , { "w1":"word12", "w2":"translate12" }
					, { "w1":"word13", "w2":"translate13" } , { "w1":"word14", "w2":"translate14" }
					, { "w1":"word15", "w2":"translate15" } , { "w1":"word16", "w2":"translate16" }
					, { "w1":"word17", "w2":"translate17" } , { "w1":"word18", "w2":"translate18" }
					];
		
		gameController.InitVocabulary(vocabulary);
		gameController.PrepareCards();
		Assert.areEqual(gameController.cards.length, 4);
		
		Assert.areEqual(gameController.cards[0].words[0].w1, "word1");
		Assert.areEqual(gameController.cards[1].words[0].w1, "word6");
		Assert.areEqual(gameController.cards[3].words[0].w1, "word16");
		
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } , { "w1":"word10", "w2":"translate10" }
					, { "w1":"word11", "w2":"translate11" } , { "w1":"word12", "w2":"translate12" }
					, { "w1":"word13", "w2":"translate13" } , { "w1":"word14", "w2":"translate14" }
					, { "w1":"word15", "w2":"translate15" } , { "w1":"word16", "w2":"translate16" }
					, { "w1":"word17", "w2":"translate17" } , { "w1":"word18", "w2":"translate18" }
					];
					
		gameController.InitVocabulary(vocabulary);
		gameController.SetWordsSeed(1);
		Assert.areEqual(gameController.vocabulary.length, 18);
		for (i in 0...gameController.vocabulary.length) 
			Assert.isNotNull(gameController.vocabulary[i]);
		
		for (i in 0...18)
		{
			for (j in gameController.vocabulary) 
				if (j.w1 == "word" + (i + 1))
				{
					gameController.vocabulary.remove(j);
					break;
				}
		}	
		Assert.areEqual(gameController.vocabulary.length, 0);
		
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } , { "w1":"word10", "w2":"translate10" }
					, { "w1":"word11", "w2":"translate11" } , { "w1":"word12", "w2":"translate12" }
					, { "w1":"word13", "w2":"translate13" } , { "w1":"word14", "w2":"translate14" }
					, { "w1":"word15", "w2":"translate15" } , { "w1":"word16", "w2":"translate16" }
					, { "w1":"word17", "w2":"translate17" } , { "w1":"word18", "w2":"translate18" }
					];
					
		gameController.InitVocabulary(vocabulary);
		gameController.SetWordsSeed(1);
		gameController.PrepareCards();
		
		Assert.areEqual(gameController.cards.length, 4);
		Assert.isNotNull(gameController.cards[0]);
		
		for (i in 0...gameController.cards[0].words.length) 
			Assert.isNotNull(gameController.cards[0].words[i]);
		
	}
	
	@Test
	public function testMarking()
	{
		vocabulary = [ { "w1":"word1", "w2":"translate1" } , { "w1":"word2", "w2":"translate2" }
					, { "w1":"word3", "w2":"translate3" } , { "w1":"word4", "w2":"translate4" }
					, { "w1":"word5", "w2":"translate5" } , { "w1":"word6", "w2":"translate6" }
					, { "w1":"word7", "w2":"translate7" } , { "w1":"word8", "w2":"translate8" }
					, { "w1":"word9", "w2":"translate9" } , { "w1":"word10", "w2":"translate10" }
					, { "w1":"word11", "w2":"translate11" } , { "w1":"word12", "w2":"translate12" }
					, { "w1":"word13", "w2":"translate13" } , { "w1":"word14", "w2":"translate14" }
					, { "w1":"word15", "w2":"translate15" } , { "w1":"word16", "w2":"translate16" }
					, { "w1":"word17", "w2":"translate17" } , { "w1":"word18", "w2":"translate18" }
					];
		gameController.InitVocabulary(vocabulary);
		gameController.PrepareCards();
		
		gameController.MarkCard(gameController.cards[0], true);
		
		Assert.areEqual(gameController.cards.length, 4);
		Assert.areEqual(gameController.getUnmarked().length, 3);
	}
}
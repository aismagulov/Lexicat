package controller;
import model.Model;
import model.vo.Card;
import model.vo.Entry;
import utils.Random;

/**
 * ...
 * @author 
 */
class GameController
{
	var cardsSeed:Int;
	var wordsSeed:Int;
	var model:Model;
	public var cards:Array<Card>;
	public var vocabulary:Array<Entry>;
	
	public var cardsRandom:Random = new Random(0);
	public var wordsRandom:Random = new Random(0);
	
	public function new(model:Model) 
	{
		this.model = model;
	}
	
	public function Init() 
	{
		InitVocabulary(model.mainModel.selectedVocabulary.vocabulary);
		SetWordsSeed(model.gameModel.wordsSeed);
		PrepareCards();
		SetCardsSeed(model.gameModel.cardsSeed);
	}
	
	public function InitVocabulary(vocabulary:Array<Entry>) 
	{
		this.vocabulary = vocabulary;
	}
	
	public function SetWordsSeed(wordsSeed:Int) 
	{
		this.wordsSeed = wordsSeed;
		wordsRandom.seed = wordsSeed;
		
		shuffleVocabulary();
	}
	
	public function MarkCard(card:Card, value:Bool)
	{
		card.marked = value;
		if (card.marked && model.gameModel.markedCards.indexOf(card.idx) == -1)
			model.gameModel.markedCards.push(card.idx);
		else if (!card.marked && model.gameModel.markedCards.indexOf(card.idx) != -1)
			model.gameModel.markedCards.remove(card.idx);
	}
	
	public function PrepareCards()
	{
		cards = [];
		
		var card:Card;
		var cardsNumber = Math.ceil(vocabulary.length / 5);
		for (i in 0...cardsNumber) 
		{
			card = new Card();
			card.words = vocabulary.splice(0, 5);
			card.marked = false;
			card.idx = i;
			
			cards.push(card);
		}
	}
	
	function SetCardsSeed(cardsSeed:Int) 
	{
		this.cardsSeed = cardsSeed;
		cardsRandom.seed = cardsSeed;
		
		shuffleCards();
	}
	
	function shuffleCards() 
	{
		var shuffled = [];
		var original = cards.copy();
		
		var idx:Int;
		for (i in 0...original.length)
		{
			idx = Math.floor(cardsRandom.nextNumber() * original.length);
			shuffled.push(original[idx]);
			original.remove(original[idx]);
		}
		
		cards = shuffled;
	}
	
	public function getUnmarked() 
	{
		var output:Array<Card> = [];
		for (card in cards) 
			if (!card.marked)
				output.push(card);
		
		return output;
	}
	
	function shuffleVocabulary() 
	{
		var shuffled = [];
		var original = vocabulary.copy();
		
		var idx:Int;
		for (i in 0...original.length)
		{
			idx = Math.floor(wordsRandom.nextNumber() * original.length);
			shuffled.push(original[idx]);
			original.remove(original[idx]);
		}
		
		vocabulary = shuffled;
	}
	
	public function Clear() 
	{
		
	}
	
}
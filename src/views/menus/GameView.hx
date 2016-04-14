package views.menus ;
import controller.GameController;
import model.vo.Card;
import motion.Actuate;
import openfl.geom.Point;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import views.game.CardState;
import views.game.CardView;
import views.widgets.ColoredButton;
import views.widgets.IconButton;

/**
 * ...
 * @author 
 */
class GameView extends Menu
{
	var gameController:GameController;
	var cards:Array<Card>;
	var cardViews:Array<CardView>;
	var lastCardView:CardView;
	
	var leftDeck:Sprite;
	var centerDeck:Sprite;
	var rightDeck:Sprite;
	var restartBtn:Button;
	var optionsBtn:Button;
	
	var canvas:Bitmap;
	var hiddenCards:Array<CardView> = [];
	
	
	public function new(gameController:GameController) 
	{
		super();
		
		this.gameController = gameController;
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		leftDeck = new Sprite();
		leftDeck.x = 120;
		leftDeck.y = Constants.H * 0.7;
		
		centerDeck = new Sprite();
		centerDeck.x = Constants.W / 2;
		centerDeck.y = Constants.H / 2 - 50;
		
		rightDeck = new Sprite();
		rightDeck.x = Constants.W - 100;
		rightDeck.y = Constants.H * 0.7;
		
		canvas = new Bitmap(new BitmapData(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, true, 0x00000000));
		
		addChild(canvas);
		addChild(leftDeck);
		addChild(centerDeck);
		addChild(rightDeck);
		
		restartBtn = UIBuilder.create(ColoredButton, { w: 250, h: 90, top: Constants.H, text:"Restart" } );
		restartBtn.x = Constants.W / 2 - 250 / 2;
		
		listen(restartBtn, onRestartClick);
		addChild(restartBtn);
		restartBtn.visible = false;
		
		optionsBtn = UIBuilder.create(IconButton, { w: 80, h: 80, left: Constants.W - 100, top: Constants.H - 100 }, ["settings"] );
		listen(optionsBtn, onOptionsClick);
		addChild(optionsBtn);
	}
	
	override public function Init() 
	{
		trace("seeds: " + model.gameModel.cardsSeed + " " + model.gameModel.wordsSeed);
		
		super.Init();
		
		canvas.bitmapData.fillRect(new Rectangle(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight), 0x00000000);
		hiddenCards = [];
		
		cards = gameController.cards;
		cardViews = [];
		lastCardView = null;
		
		restartBtn.visible = false;
		
		//trace("cards.length " + (cards.length));
		var cardView:CardView;
		for (i in 0...cards.length)
		{
			cardView = new CardView();
			//trace("card " + i + ": " + (cards[i] != null));
			cardView.setData(cards[i], model.mainModel.forward);
			cardViews.push(cardView);
			cardView.setState(CardState.COVER);
			cardView.markCardHandler = gameController.MarkCard;
			
			//trace("model.gameModel.markedCards " + model.gameModel.markedCards);
			
			if (model.gameModel.markedCards.indexOf(cards[i].idx) != -1)
			{
				rightDeck.addChild(cardView);
				cardView.visible = false;
			}
			else
			{
				leftDeck.addChildAt(cardView, 0);
				listen(cardView, onDrawCard);
				cardView.visible = false;
			}
		}
		
		if (leftDeck.numChildren > 0)
			leftDeck.getChildAt(leftDeck.numChildren - 1).visible = true;
		if (rightDeck.numChildren > 0)
			rightDeck.getChildAt(rightDeck.numChildren - 1).visible = true;
	}
	
	override function onKeyDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Constants.BACK_KEY)
		{
			menuManager.SetMenu(MenuTypes.MAIN);
		}
	}
	
	override public function Clear() 
	{
		super.Clear();
		
		leftDeck.removeChildren();
		centerDeck.removeChildren();
		rightDeck.removeChildren();
		
		cards = [];
		
		for (cardView in cardViews) 
		{
			unlisten(cardView, onDrawCard);
			cardView.Clear();
		}
		cardViews = [];
	}
	
	function onDrawCard(cardView:InteractiveObject)
	{
		if (lastCardView != null)
		{
			var rx = (Math.random() - 0.5) * 200;
			var ry = (Math.random() + 0.5) * 100 + 50;
			var rr = (Math.random() - 0.5) * 40;
			Actuate.tween(lastCardView, 1, { x: rx, y: ry, scaleX: 0.75, scaleY: 0.75, rotation: rr } )
					.onComplete(
						function(cardView:CardView)
						{
							if (cardView.parent == null)
								return;
							
							var m:Matrix = new Matrix();
							var globalPoint:Point = cardView.parent.localToGlobal(new Point(cardView.x, cardView.y));
							//trace("rr " + cardView.x + " " + cardView.y);
							m.scale(cardView.scaleX, cardView.scaleY);
							m.rotate(cardView.rotation * Math.PI / 180);
							m.translate(globalPoint.x, globalPoint.y);
							
							canvas.bitmapData.draw(cardView, m);
							
							if (centerDeck.contains(cardView))
								centerDeck.removeChild(cardView);
							
							hiddenCards.push(cardView);
						}, [lastCardView] );
		}
		
		unlisten(cardView, onDrawCard);
		
		centerDeck.addChild(cardView);
		cast (cardView, CardView).setState(CardState.FRONT);
		cast (cardView, CardView).enable();
		
		lastCardView = cast cardView;
		
		if (leftDeck.numChildren == 0)
		{
			Actuate.tween(restartBtn, 0.3, { y: Constants.H - 100 } );
			restartBtn.visible = true;
		}
		
		if (leftDeck.numChildren > 0)
			leftDeck.getChildAt(leftDeck.numChildren - 1).visible = true;
	}
	
	function onOptionsClick(btn:InteractiveObject)
	{
		menuManager.SetMenu(MenuTypes.OPTIONS);
	}
	
	function onRestartClick(btn:InteractiveObject) 
	{
		lastCardView = null;
		
		canvas.bitmapData.fillRect(new Rectangle(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight), 0x00000000);
		
		Actuate.tween(restartBtn, 0.3, { y: Constants.H } )
				.onComplete(function() { restartBtn.visible = false; } );
		
		
		
		var centerDeckCards:Array<CardView> = [];
		while (centerDeck.numChildren > 0)
		{
			centerDeckCards.push(cast centerDeck.getChildAt(0));
			centerDeck.removeChildAt(0);
		}
		
		var allCards = hiddenCards.concat(centerDeckCards);
		
		var cardView:CardView;
		for (i in 0...allCards.length)
		{
			cardView = cast allCards[i];
			
			cardView.reset();
			listen(cardView, onDrawCard);
			cardView.setState(CardState.COVER);
			cardView.x = 0;
			cardView.y = 0;
			cardView.rotation = 0;
			
			if (cardView.isMarked())
			{
				rightDeck.addChildAt(cardView, 0);
				cardView.visible = false;
			}
			else
			{
				leftDeck.addChildAt(cardView, 0);
				cardView.visible = false;
			}
		}
		
		if (rightDeck.numChildren > 0)
			rightDeck.getChildAt(rightDeck.numChildren - 1).visible = true;
		if (leftDeck.numChildren > 0)
			leftDeck.getChildAt(leftDeck.numChildren - 1).visible = true;
			
		allCards = [];
	}
	
}
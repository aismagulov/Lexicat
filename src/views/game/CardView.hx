package views.game ;
import flash.events.Event;
import haxe.Timer;
import model.vo.Card;
import openfl.display.Shape;
import openfl.filters.GlowFilter;
import openfl.geom.Point;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.filters.DropShadowFilter;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Toggle;
import views.menus.InteractionListener;
import views.widgets.IconToggle;

/**
 * ...
 * @author 
 */
class CardView extends InteractionListener
{
	public var markCardHandler:Card->Bool->Void;
	var cardVo:Card;
	var cardTf:TextField;
	var labelTf:TextField;
	var front:Bool;
	
	var markBtn:Toggle;
	var bg:Sprite;
	var layout:Sprite;
	var backView:Bitmap;
	var frontView:Bitmap;
	var forward:Bool;
	
	public function new() 
	{
		super(); 
		
		front = true;
		
		layout = new Sprite();
		addChild(layout);
		
		backView = new Bitmap(Assets.getBitmapData("img/skins/cardBack.png"));
		frontView = new Bitmap(Assets.getBitmapData("img/skins/cardFront.png"));
		frontView.smoothing = true;
		backView.smoothing = true;
		
		bg = new Sprite();
		bg.buttonMode = true;
		bg.useHandCursor = true;
		bg.addChild(backView);
		bg.x = - bg.width / 2;
		bg.y = - bg.height / 2;
		layout.addChild(bg);
		
		var shadowRect = frontView.bitmapData.rect.clone();
		var offset = 50;
		shadowRect.x -= offset;
		shadowRect.width += 2 * offset;
		shadowRect.height += 2 * offset;
		
		//trace("frontView.width " + frontView.width);
		
		cardTf = new TextField();
		cardTf.width = 330;
		cardTf.height = 330;
		cardTf.embedFonts = true;
		cardTf.x = - cardTf.width / 2;
		//cardTf.autoSize = TextFieldAutoSize.CENTER;
		cardTf.mouseEnabled = false;
		cardTf.defaultTextFormat = TextFormats.cardTextFormat;
		layout.addChild(cardTf);
		
		markBtn = UIBuilder.create(IconToggle, { w: 50, h: 50, left: 300 / 2- 30, top: 160 / 2 - 30 } );
		markBtn.addEventListener(WidgetEvent.CHANGE, onMarkChange);
		layout.addChild(markBtn);
	}
	
	function onBgClick(bg:InteractiveObject) 
	{
		if (cardVo == null)
			return;
		
		front = !front;
		
		if (front)
			setState(CardState.FRONT);
		else
			setState(CardState.FLIPPED);
	}
	
	public function display()
	{
		cardTf.text = "";
		
		if (cardVo == null || cardVo.words == null)
		{
			trace("card.words is null");
			return;
		}
		
		bg.removeChildren();
		bg.addChild(frontView);
		bg.x = - bg.width / 2;
		bg.y = - bg.height / 2;
	}
	
	private function onMarkChange(e:Event):Void 
	{
		if (markCardHandler != null)
			markCardHandler(cardVo, markBtn.selected);
	}
	
	public function setData(cardVo:Card, forward:Bool)
	{
		this.forward = forward;
		this.cardVo = cardVo;
	}
	
	public function reset()
	{
		front = true;
	}
	
	public function isMarked():Bool
	{
		return cardVo.marked;
	}
	
	public function enable()
	{
		Timer.delay(
			function() 
			{ 
				listen(bg, onBgClick);
			}, 300);
	}
	
	public function setState(state:String) 
	{
		switch (state)
		{
			case CardState.COVER:
				//this.filters = [new DropShadowFilter(3, 45, 0x333333, 0.5, 1, 1)];
				//this.filters = [new GlowFilter(0x333333, 0.5, 26, 26)];
				
				markBtn.visible = false;
				cardTf.visible = false;
				unlisten(bg, onBgClick);
				
				bg.removeChildren();
				bg.addChild(backView);
				bg.x = - bg.width / 2;
				bg.y = - bg.height / 2;
				
				//var maskShape = new Shape();
				//maskShape.graphics.beginFill(0, 1);
				//maskShape.graphics.drawCircle(50, 50, 50);
				//maskShape.graphics.endFill();
				//bg.mask = maskShape;
				//bg.addChild(maskShape);
				
				this.scaleX = 0.75;
				this.scaleY = 0.75;
			
			case CardState.FRONT:
				//this.filters = [new DropShadowFilter(16, 90, 0x333333, 0.5, 20, 20)];
				//this.filters = [new GlowFilter(0x333333, 0.5, 6, 6)];
				this.scaleX = 1.5;
				this.scaleY = 1.5;
				
				cardTf.visible = true;
				display();
				
				for (i in 0...cardVo.words.length) 
					if (cardVo.words[i] != null)
						cardTf.text += ((forward) ? cardVo.words[i].w1 : cardVo.words[i].w2) + "\n";
				
				cardTf.y = - cardTf.textHeight / 2;
		
			case CardState.FLIPPED:
				this.scaleX = 1.5;
				this.scaleY = 1.5;
				
				cardTf.visible = true;
				markBtn.visible = true;
				display();
				
				for (i in 0...cardVo.words.length) 
					if (cardVo.words[i] != null)
						cardTf.text += ((forward) ? cardVo.words[i].w2 : cardVo.words[i].w1) + "\n";
				
				cardTf.y = - cardTf.textHeight / 2;
		}
	}
	
	public function Clear()
	{
		cardVo = null;
		layout.removeChildren();
		unlisten(bg, onBgClick);
		markBtn.removeEventListener(WidgetEvent.CHANGE, onMarkChange);
	}
}
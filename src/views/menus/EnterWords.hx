package views.menus;
import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.TextEvent;
import openfl.text.TextField;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Box;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.InputText;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Widget;
import views.widgets.ColoredButton;
import views.widgets.WordRenderer;

/**
 * Два текстовых поля, кнопка ок, список всех слов с возможностью удалить пару
 * @author 
 */
class EnterWords extends Menu
{
	var tf1:InputText;
	var tf2:InputText;
	var okBtn:Button;
	var backBtn:Button;
	
	var words1:Array<String> = ["w1", "w2", "w3", "w4", "w1", "w2", "w3", "w4", "w1", "w2", "w3", "w4"];
	var words2:Array<String> = ["t1", "t2", "t3", "t4", "t1", "t2", "t3", "t4", "t1", "t2", "t3", "t4"];
	var list:Scroll;
	
	var wordsContainer:Box;
	
	public function new() 
	{
		super();
	}
	
	override function initLayout() 
	{
		super.initLayout();
		
		wordsContainer = UIBuilder.create(Box, { w: Constants.W, h: 30, left: 0, top:0 } );
		wordsContainer.autoHeight = true;
		
		list = UIBuilder.create(Scroll, { w: Constants.W, h: Constants.H - 60, left: 0, top:0, children : [wordsContainer]});
		list.vScroll = true;
		list.hScroll = false;
		list.dragScroll = true;
		list.wheelScroll = true;
		list.y = 60;
		list.vBar.visible = false;
		list.hBar.visible = false;
		
		okBtn = UIBuilder.create(ColoredButton, { w: 100, h: 60, left: Constants.W - 200, top:0, text:"Ok" } );
		listen(okBtn, onOkClick);
		
		backBtn = UIBuilder.create(ColoredButton, { w: 100, h: 60, left: Constants.W - 100, top:0, text:"Back" } );
		listen(backBtn, onBackClick);
		
		tf1 = UIBuilder.create(InputText, { w: 200, h: 60, left: 0, top:0, text:"" } );
		tf2 = UIBuilder.create(InputText, { w: 200, h: 60, left: 200, top:0, text:"" } );
		
		
		//tf1.skin = skinPaint;
		//tf2.skin = skinPaint;
		
		tf1.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
		tf1.addEventListener(Event.CHANGE, onTextInput);
		tf2.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
		tf2.addEventListener(Event.CHANGE, onTextInput);
		
		layout.addChild(list);
		
		layout.addChild(tf1);
		layout.addChild(tf2);
		layout.addChild(okBtn);
		layout.addChild(backBtn);
	}
	
	override public function Init() 
	{
		super.Init();
		
		repopulate();
	}
	
	function repopulate() 
	{
		wordsContainer.removeChildren();
		
		var wordRenderer:WordRenderer;
		for (i in 0...words1.length) 
		{
			wordRenderer = UIBuilder.create(WordRenderer, {w:200, h:100 }, [words1[i], words2[i]]);
			wordsContainer.addChild(wordRenderer);
		}
		
		list.refresh();
		
		trace("words1.length " + words1.length);
		trace("wordsContainer.numChildren " + wordsContainer.numChildren);
	}
	
	private function onTextInput(e:Event):Void 
	{
		if (tf1.text != "" && tf2.text != "")
			okBtn.disabled = false;
		else
			okBtn.disabled = true;
	}
	
	function onBackClick(btn:InteractiveObject) 
	{
		menuManager.SetMenu(MenuTypes.MAIN);
	}
	
	private function onOkClick(btn:InteractiveObject):Void 
	{
		saveWord();
		tf1.text = "";
		tf2.text = "";
	}
	
	function saveWord() 
	{
		words1.push(tf1.text);
		words2.push(tf2.text);
		
		trace("words1 " + tf1.text);
		trace("words2 " + tf2.text);
		
		repopulate();
	}
}
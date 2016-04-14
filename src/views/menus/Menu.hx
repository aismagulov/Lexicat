package views.menus;

import controller.MainController;
import model.Model;
import motion.Actuate;
import openfl.display.BlendMode;
import openfl.display.GradientType;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.filters.BlurFilter;
import openfl.geom.Matrix;
import openfl.Lib;
import ru.stablex.ui.widgets.Button;
import views.menus.MenuManager;

/**
 * ...
 * @author 
 */
class Menu extends InteractionListener
{
	public var model:Model;
	public var mainController:MainController;
	
	var layout:Sprite;
	var menuManager:MenuManager;
	
	
	public function new() 
	{
		super();
		
		initLayout();
	}
	
	public function setManager(menuManager:MenuManager) 
	{
		this.menuManager = menuManager;
		
	}
	
	public function Init() 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.focus = Lib.current.stage;
	}
	
	private function verticalFloat(buttons:Array<Button>)
	{
		for (btn in buttons) 
		{
			btn.alpha = 0;
			btn.disabled = true;
			btn.y = btn.y + 50;
		}
		
		for (i in 0...buttons.length) 
		{
			Actuate.tween(buttons[i], 0.3, { alpha: 1, y: 100 * i } )
					.delay(i * 0.1)
					.onComplete(function() {buttons[i].disabled = false;} );
		}
	}
	
	public function Clear() 
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		
	}
	
	private function initLayout()
	{
		layout = new Sprite();
		addChild(layout);
		
		var shape = new Shape();
		shape.graphics.beginFill(0x445F73, 1);
		shape.graphics.drawRect(0, 0, Constants.W, Constants.H);
		layout.addChild(shape);
		
		var light = new Shape();
		var lightWidth:Float = Constants.W * 0.75;
		var lightHeight:Float = Constants.H;
		var m:Matrix = new Matrix();
		
		
		m.createGradientBox(lightWidth, lightWidth, 0, 0, 0);
		light.graphics.beginGradientFill(GradientType.RADIAL, [0xDBDBDB, 0xDBDBDB], [0.4, 0], [0, 255], m);
		light.graphics.drawEllipse( 0, 0, lightWidth, lightWidth);
		light.scaleY = lightHeight / lightWidth;
		light.x = Constants.W / 2 - light.width / 2;
		light.y = Constants.H / 2 - light.height / 2;
		
		//light.filters = [new BlurFilter(50, 50, 3)];
		//light.blendMode = BlendMode.OVERLAY;
		layout.addChild(light);
	}
	
}
package views.menus;

import openfl.display.InteractiveObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import ru.stablex.ui.widgets.Button;

/**
 * ...
 * @author 
 */
class InteractionListener extends Sprite
{
	var listeners:Map<InteractiveObject, InteractiveObject->Void> = new Map<InteractiveObject, InteractiveObject->Void>();
	
	public function new() 
	{
		super();
		
	}
	
	private function unlisten(button:InteractiveObject, listenerFunc:InteractiveObject -> Void)
	{
		listeners.remove(button);
	}
	
	private function listen(button:InteractiveObject, listenerFunc:InteractiveObject -> Void)
	{
		listeners.set(button, listenerFunc);
		
		
//#if flash
		if (!button.hasEventListener(MouseEvent.CLICK))
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
//#else
		//if (!button.hasEventListener(TouchEvent.TOUCH_END))
			//button.addEventListener(TouchEvent.TOUCH_END, onButtonTouch);
//#end
	}
	
	private function onButtonClick(e:MouseEvent):Void 
	{
		if (listeners.get(e.currentTarget) != null)
			listeners.get(e.currentTarget)(e.currentTarget);
	}
	
	private function onButtonTouch(e:TouchEvent):Void 
	{
		if (listeners.get(e.currentTarget) != null)
			listeners.get(e.currentTarget)(e.currentTarget);
	}
}
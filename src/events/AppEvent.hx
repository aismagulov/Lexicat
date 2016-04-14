package events;

import openfl.events.Event;

/**
 * ...
 * @author 
 */
class AppEvent extends Event
{
	static public inline var SEED_CHANGED:String = "seedChanged";
	static public inline var GAME_RESET:String = "gameReset";
	static public inline var SET_GAME_STATE:String = "setGameState";
	static public inline var SET_APP_STATE:String = "setAppState";

	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
		
	}
	
}
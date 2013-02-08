package barmatz.asteroids
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	public interface ICollision extends IEventDispatcher
	{
		function hitTestObject(obj:DisplayObject):Boolean
	}
}
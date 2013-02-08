package barmatz.asteroids.events
{
	import barmatz.asteroids.ICollision;
	
	import flash.events.Event;
	
	public class CollisionEvent extends Event
	{
		public static const HIT:String = 'hit';
		
		private var _hitObject:ICollision;
		
		public function CollisionEvent(type:String, hitObject:ICollision, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_hitObject = hitObject;
		}
		
		public override function clone():Event
		{
			return new CollisionEvent(type, hitObject, bubbles,  cancelable);
		}
		
		public override function toString():String
		{
			return formatToString('CollisionEvent', 'type', 'hitObject', 'bubbles',  'eventPhase');
		}
		
		public function get hitObject():ICollision
		{
			return _hitObject;
		}
	}
}
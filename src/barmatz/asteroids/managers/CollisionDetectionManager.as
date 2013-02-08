package barmatz.asteroids.managers
{
	import barmatz.asteroids.ICollision;
	import barmatz.asteroids.errors.CollectionError;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import barmatz.asteroids.events.CollisionEvent;
	
	public class CollisionDetectionManager
	{
		private var objects:Vector.<ICollision>,
					timer:Timer;
		
		public function CollisionDetectionManager(delay:Number)
		{
			objects = new Vector.<ICollision>();
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
		}
		
		public function destroy():void
		{
			objects.forEach(function(a:ICollision, b:int, c:Vector.<ICollision>):void
			{
				unregisterObject(a);
			});
			objects = null;
			
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer.reset();
			timer = null;
		}
		
		public function registerObject(object:ICollision):void
		{
			if(objects.indexOf(object) == -1)
				objects.push(object);	
			else
				throw new CollectionError('Object already registered.');
		}
		
		public function unregisterObject(object:ICollision):void
		{
			if(objects.indexOf(object) > -1)
				objects = objects.filter(function(a:ICollision, b:int, c:Vector.<ICollision>):Boolean
				{
					return a != object;
				});	
			else
				throw new CollectionError('Object cannot be found.');
		}
		
		public function start():void
		{
			runTests();
			if(!timer.running)
				timer.start();
		}
		
		public function stop():void
		{
			if(timer.running)
				timer.stop();
		}
		
		private function runTests():void
		{
			objects.forEach(function(a:ICollision, b:int, c:Vector.<ICollision>):void
			{
				objects.forEach(function(d:ICollision, e:int, f:Vector.<ICollision>):void
				{
					if(a != d)
					{
						if(a.hitTestObject(DisplayObject(d)))
						{
							a.dispatchEvent(new CollisionEvent(CollisionEvent.HIT, d));
							d.dispatchEvent(new CollisionEvent(CollisionEvent.HIT, a));
						}
					}
				});		
			});		
		}
		
		private function onTimer(event:TimerEvent):void
		{
			runTests();
		}
		
		public function get delay():Number
		{
			return timer.delay;
		}
		
		public function set delay(value:Number):void
		{
			timer.delay = value;
		}
	}
}
package barmatz.asteroids.managers
{
	import barmatz.asteroids.display.Bullet;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	internal class FiringManagerController extends DisplayObjectManagerController
	{
		private var model:FiringManagerModel,
					target:DisplayObject,
					_timer:Timer,
					_collisionDetectionManager:CollisionDetectionManager;
		
		public function FiringManagerController(container:DisplayObjectContainer, target:DisplayObject, model:FiringManagerModel)
		{
			super(container, Bullet);
			this.target = target;
			this.model = model;
		}
		
		public override function destroy():void
		{
			super.destroy();
			
			if(_timer)
				destroyTimer();
			
			target = null;
			model = null;
		}
		
		private function createTimer():void
		{
			_timer = new Timer(model.delay);
			_timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
		}
		
		private function destroyTimer():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.reset();
			_timer = null;
		}
		
		protected override function createObject():*
		{
			const BULLET:Bullet = super.createObject();
			BULLET.x = target.x;
			BULLET.y = target.y;
			BULLET.rotation = target.rotation;
			BULLET.stage ? BULLET.addEventListener(Event.ENTER_FRAME, onBulletEnterFrame, false, 0, true) : BULLET.addEventListener(Event.ADDED_TO_STAGE, onBulletAddedToStage, false, 0, true);
			collisionDetectionManager.registerObject(BULLET);
		}
		
		protected override function destroyObject(object:*):void
		{
			collisionDetectionManager.unregisterObject(object);
			object.removeEventListener(Event.ADDED_TO_STAGE, onBulletAddedToStage);
			object.removeEventListener(Event.REMOVED_FROM_STAGE, onBulletRemovedFromStage);
			object.removeEventListener(Event.ENTER_FRAME, onBulletEnterFrame);
			super.destroyObject(object);
		}
		
		public function startFiring():void
		{
			if(!timer.running)
			{
				createObject();
				timer.start();
			}
		}
		
		public function stopFiring():void
		{
			if(timer.running)
				timer.stop();
		}
		
		private function onTimer(event:TimerEvent):void
		{
			createObject();
		}
		
		private function onBulletAddedToStage(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, onBulletAddedToStage);
			event.currentTarget.addEventListener(Event.REMOVED_FROM_STAGE, onBulletRemovedFromStage, false, 0, true);
			event.currentTarget.addEventListener(Event.ENTER_FRAME, onBulletEnterFrame, false, 0, true);
		}
		
		private function onBulletRemovedFromStage(event:Event):void
		{
			event.currentTarget.addEventListener(Event.ADDED_TO_STAGE, onBulletAddedToStage, false, 0, true);
			event.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, onBulletRemovedFromStage);
			event.currentTarget.removeEventListener(Event.ENTER_FRAME, onBulletEnterFrame);
		}
		
		private function onBulletEnterFrame(event:Event):void
		{
			if(event.currentTarget.stage && (
				event.currentTarget.x < event.currentTarget.stage.x - event.currentTarget.width || 
				event.currentTarget.x > event.currentTarget.stage.stageWidth + event.currentTarget.width ||
				event.currentTarget.y < event.currentTarget.stage.y - event.currentTarget.height || 
				event.currentTarget.y > event.currentTarget.stage.stageHeight + event.currentTarget.height
			))
				destroyObject(event.currentTarget);
		}
		
		private function get timer():Timer
		{
			if(!_timer)
				createTimer();
			return _timer;
		}
		
		public function get collisionDetectionManager():CollisionDetectionManager
		{
			return _collisionDetectionManager;
		}
		
		public function set collisionDetectionManager(value:CollisionDetectionManager):void
		{
			_collisionDetectionManager = value;
		}
	}
}
package barmatz.asteroids.managers
{
	import barmatz.asteroids.display.Asteroid;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	internal class AsteroidManagerController extends DisplayObjectManagerController
	{
		private var model:AsteroidManagerModel,
					_collisionDetectionManager:CollisionDetectionManager;
		
		public function AsteroidManagerController(container:DisplayObjectContainer, model:AsteroidManagerModel)
		{
			super(container, Asteroid);
			this.model = model;
		}
		
		public override function destroy():void
		{
			model = null;
			super.destroy();
		}
		
		public function create(total:int):void
		{
			var i:int = 0;
			while(++i <= total)
				createObject();
		}
		
		protected override function createObject():*
		{
			const ASTEROID:Asteroid = super.createObject();
			ASTEROID.x = Math.random() < .5 ? model.boundingBox.left : model.boundingBox.right;
			ASTEROID.y = Math.random() < .5 ? model.boundingBox.top : model.boundingBox.bottom;
			ASTEROID.addEventListener(Event.ENTER_FRAME, onAsteroidEnterFrame, false, 0, true);
			collisionDetectionManager.registerObject(ASTEROID);
		}
		
		protected override function destroyObject(object:*):void
		{
			collisionDetectionManager.unregisterObject(object);
			object.removeEventListener(Event.ENTER_FRAME, onAsteroidEnterFrame);
			super.destroyObject(object);
		}
		
		private function onAsteroidEnterFrame(event:Event):void
		{
			if(
				event.currentTarget.x < model.boundingBox.left - event.currentTarget.width || 
				event.currentTarget.x > model.boundingBox.right + event.currentTarget.width || 
				event.currentTarget.y < model.boundingBox.top - event.currentTarget.height || 
				event.currentTarget.y > model.boundingBox.bottom + event.currentTarget.height
			)
			{
				destroyObject(event.currentTarget);
				createObject();
			}
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
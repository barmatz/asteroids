package barmatz.asteroids.managers
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class AsteroidsManager
	{
		private var model:AsteroidManagerModel,
					controller:AsteroidManagerController;
					
		public function AsteroidsManager(container:DisplayObjectContainer)
		{
			model = new AsteroidManagerModel();
			controller = new AsteroidManagerController(container, model);
		}

		public function destroy():void
		{
			model.destroy();
			model = null;
			
			controller.destroy();
			controller = null
		}
		
		public function create(total:int):void
		{
			controller.create(total);
		}
		
		public function get boundingBox():Rectangle
		{
			return model.boundingBox;
		}

		public function set boundingBox(value:Rectangle):void
		{
			model.boundingBox = value;
		}

		public function get collisionDetectionManager():CollisionDetectionManager
		{
			return controller.collisionDetectionManager;
		}

		public function set collisionDetectionManager(value:CollisionDetectionManager):void
		{
			controller.collisionDetectionManager = value;
		}
	}
}
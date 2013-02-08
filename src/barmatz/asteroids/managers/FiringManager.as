package barmatz.asteroids.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class FiringManager
	{
		private var model:FiringManagerModel,
					controller:FiringManagerController;
					
		public function FiringManager(container:DisplayObjectContainer, target:DisplayObject)
		{
			model = new FiringManagerModel();
			controller = new FiringManagerController(container, target, model);
		}
		
		public function destroy():void
		{
			model.destroy();
			model = null;

			controller.destroy();
			controller = null;
		}
		
		public function startFiring():void
		{
			controller.startFiring();
		}
		
		public function stopFiring():void
		{
			controller.stopFiring();
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
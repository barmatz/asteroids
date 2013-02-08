package barmatz.asteroids.display
{
	import barmatz.asteroids.events.CollisionEvent;
	import barmatz.asteroids.managers.FiringManager;
	import barmatz.mvc.AbstractController;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	internal class ShipController extends AbstractController
	{
		private var model:ShipModel,
					view:Ship,
					_firingManager:FiringManager;
		
		public function ShipController(view:Ship)
		{
			this.model = new ShipModel();
			this.view = view;
			view.cacheAsBitmap = true;
			view.draw(model.width, model.height);
			view.addEventListener(Event.ENTER_FRAME, onViewEnterFrame, false, 0, true);
			view.addEventListener(CollisionEvent.HIT, onViewHit, false, 0, true);
			view.stage ? addViewStageListeners() : view.addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, false, 0, true);
		}
		
		private function addViewStageListeners():void
		{
			view.stage.addEventListener(KeyboardEvent.KEY_DOWN, onViewStageKeyDown, false, 0, true);
			view.stage.addEventListener(KeyboardEvent.KEY_UP, onViewStageKeyUp, false, 0, true);
		}
		
		private function removeViewStageListeners():void
		{
			view.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onViewStageKeyDown);
			view.stage.removeEventListener(KeyboardEvent.KEY_UP, onViewStageKeyUp);
		}
		
		public function destroy():void
		{
			firingManager.destroy();
			firingManager = null;

			model.destroy();
			model = null;

			removeViewStageListeners();
			view.removeEventListener(CollisionEvent.HIT, onViewHit);
			view.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
			view.removeEventListener(Event.ENTER_FRAME, onViewEnterFrame);
			view = null;
		}
		
		private function keepInStage():void
		{
			if(view.stage)
			{
				if(view.x < view.stage.x - view.width)
					view.x = view.stage.stageWidth + view.width;
				else if(view.x > view.stage.stageWidth + view.width)
					view.x = view.stage.stage.x - view.width;

				if(view.y < view.stage.y - view.height)
					view.y = view.stage.stageHeight + view.height;
				else if(view.y > view.stage.stageHeight + view.height)
					view.y = view.stage.stage.y - view.height;
			}
		}
		
		private function onViewAddedToStage(event:Event):void
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
			addViewStageListeners();
		}
		
		private function onViewStageKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					model.increaseSpeed = true;
					break;
				case Keyboard.DOWN:
					model.decreaseSpeed = true;
					break;
				case Keyboard.RIGHT:
					model.rotate = ShipModel.RIGHT;
					break;
				case Keyboard.LEFT:
					model.rotate = ShipModel.LEFT;
					break;
				case Keyboard.SPACE:
					firingManager.startFiring();
					break;
			}
		}
		
		private function onViewStageKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					model.increaseSpeed = false;
					break;
				case Keyboard.DOWN:
					model.decreaseSpeed = false;
					break;
				case Keyboard.RIGHT:
				case Keyboard.LEFT:
					model.rotate = null;
					break;
				case Keyboard.SPACE:
					firingManager.stopFiring();
					break;
			}
		}
		
		private function onViewHit(event:CollisionEvent):void
		{
		}
		
		private function onViewEnterFrame(event:Event):void
		{
			view.x += model.x;
			view.y += model.y;
			view.rotation = model.rotation;
			keepInStage();
		}
		
		
		public function get firingManager():FiringManager
		{
			return _firingManager;
		}
		
		public function set firingManager(value:FiringManager):void
		{
			_firingManager = value;
		}
	}
}
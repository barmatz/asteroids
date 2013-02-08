package barmatz.asteroids.display
{
	import barmatz.asteroids.events.CollisionEvent;
	import barmatz.mvc.AbstractController;
	
	import flash.events.Event;
	
	internal class AsteroidController extends AbstractController
	{
		private var model:AsteroidModel,
					view:Asteroid;
					
		public function AsteroidController(view:Asteroid)
		{
			model = new AsteroidModel();
			this.view = view;
			view.cacheAsBitmap = true;
			view.draw(model.width, model.height);
			view.addEventListener(Event.ENTER_FRAME, onViewEnterFrame, false, 0, true);
			view.addEventListener(CollisionEvent.HIT, onViewHit, false, 0, true);
		}
		
		public function destroy():void
		{
			model.destroy();
			model = null;
			
			view.removeEventListener(CollisionEvent.HIT, onViewHit);
			view.removeEventListener(Event.ENTER_FRAME, onViewEnterFrame);
			view.parent.removeChild(view);
			view = null;
		}
		
		private function onViewHit(event:CollisionEvent):void
		{
			if(event.hitObject is Bullet)
				destroy();
			else
				model.reverseX();
		}
		
		private function onViewEnterFrame(event:Event):void
		{
			view.x += model.x;
			view.y += model.y;
			view.rotation += model.rotation * .01;
		}
	}
}
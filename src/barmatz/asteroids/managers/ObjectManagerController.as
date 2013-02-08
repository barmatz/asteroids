package barmatz.asteroids.managers
{
	import barmatz.mvc.AbstractController;
	
	import flash.utils.flash_proxy;
	
	public class ObjectManagerController extends AbstractController
	{
		protected var objectType:Class;
		
		private var objects:Array;
		
		public function ObjectManagerController(objectType:Class)
		{
			this.objectType = objectType;
			objects = [];
		}
		
		public function destroy():void
		{
			objects.forEach(function(a:*, b:int, c:Array):void
			{
				destroyObject(a);
			});
			objects = null;
			objectType = null;
		}
		
		protected function createObject():* 
		{
			const OBJECT:* = new objectType();
			objects.push(OBJECT);
			return OBJECT;
		}
		
		protected function destroyObject(object:*):void 
		{
			objects = objects.filter(function(a:*, b:int, c:Array):Boolean
			{
				return a != object;
			});
		}
	}
}
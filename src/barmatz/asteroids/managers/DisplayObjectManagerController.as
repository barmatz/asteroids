package barmatz.asteroids.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class DisplayObjectManagerController extends ObjectManagerController
	{
		private var container:DisplayObjectContainer;
		
		public function DisplayObjectManagerController(container:DisplayObjectContainer, objectType:Class = null)
		{
			super(objectType || DisplayObject);
			this.container = container;
		}
		
		public override function destroy():void
		{
			container = null;
			super.destroy();
		}
		
		protected override function createObject():*
		{
			const OBJECT:* = super.createObject();
			container.addChild(OBJECT);
			return OBJECT;
		}
		
		protected override function destroyObject(object:*):void
		{
			if(object.parent)
				object.parent.removeChild(object);
			super.destroyObject(object);
		}
	}
}
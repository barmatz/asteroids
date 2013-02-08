package barmatz.asteroids.managers
{
	import barmatz.mvc.AbstractModel;
	import flash.geom.Rectangle;
	
	internal class AsteroidManagerModel extends AbstractModel
	{
		private var _boundingBox:Rectangle;
		
		public function AsteroidManagerModel()
		{
			super();
		}

		public function destroy():void
		{
			_boundingBox = null;
		}
		
		public function get boundingBox():Rectangle
		{
			return _boundingBox;
		}

		public function set boundingBox(value:Rectangle):void
		{
			_boundingBox = value;
		}
	}
}
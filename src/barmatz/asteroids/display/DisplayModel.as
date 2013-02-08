package barmatz.asteroids.display
{
	import barmatz.mvc.AbstractModel;
	
	public class DisplayModel extends AbstractModel
	{
		private var _x:Number = 0,
					_y:Number = 0,
					_width:Number = 0,
					_height:Number = 0,
					_rotation:Number = 0;
		
		public function DisplayModel()
		{
		}
		
		public function destroy():void
		{
			_x = _y = _width = _height = _rotation = NaN;
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		public function set width(value:Number):void
		{
			_width = value;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function set height(value:Number):void
		{
			_height = value;
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			_rotation = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
	}
}
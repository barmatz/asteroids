package barmatz.asteroids.display
{
	import flash.errors.IllegalOperationError;

	public class MovementModel extends DisplayModel
	{
		private var _velocity:Number = 0,
					_increaseSpeed:Boolean,
					_decreaseSpeed:Boolean;
		
		protected var acceleration:Number = 0,
					  minVelocity:Number = 0,
					  maxVelocity:Number = 0,
					  modulX:int = 1,
					  modulY:int = 1;
		
		public function MovementModel()
		{
		}
		
		public override function destroy():void
		{
			acceleration = minVelocity = maxVelocity = _velocity = NaN;
			_increaseSpeed = _decreaseSpeed = false;
			super.destroy();
		}
		
		public static function degreesToRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}
		
		public static function radiansToDegrees(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		public function reverseX():void
		{
			modulX *= -1;
		}
		
		public function reverseY():void
		{
			modulY *= -1;
		}
		
		public function get velocity():Number
		{
			if(increaseSpeed && _velocity < maxVelocity)
				_velocity += acceleration;
			else if(decreaseSpeed && _velocity > minVelocity)
				_velocity -= acceleration;
			return _velocity;
		}
		
		public override function get x():Number
		{
			return velocity * Math.cos(degreesToRadians(rotation)) * modulX;
		}
		
		public override function set x(value:Number):void
		{
			throw new IllegalOperationError('Property is ready-only');
		}
		
		public override function get y():Number
		{
			return velocity * Math.sin(degreesToRadians(rotation)) * modulY;
		}
		
		public override function set y(value:Number):void
		{
			throw new IllegalOperationError('Property is ready-only');
		}
		
		public function get increaseSpeed():Boolean
		{
			return _increaseSpeed;
		}
		
		public function set increaseSpeed(value:Boolean):void
		{
			_increaseSpeed = value;
			if(decreaseSpeed)
				decreaseSpeed = false;
		}
		
		public function get decreaseSpeed():Boolean
		{
			return _decreaseSpeed;
		}
		
		public function set decreaseSpeed(value:Boolean):void
		{
			_decreaseSpeed = value;
			if(increaseSpeed)
				_increaseSpeed = false;
		}
	}
}
package barmatz.asteroids.display
{
	import flash.errors.IllegalOperationError;

	internal class AsteroidModel extends MovementModel
	{
		public static const MIN_RADIUS:Number = 10,
							MAX_RADIUS:Number = 50,
							MIN_VELOCITY:Number = .5,
							MAX_VELOCITY:Number = 5,
							MIN_ROTATION:Number = 0,
							MAX_ROTATION:Number = 360;
		
		private var _velocity:Number = MIN_VELOCITY + (Math.random() * (MAX_VELOCITY - MIN_VELOCITY)),
					_rotation:Number = MIN_ROTATION + (Math.random() * (MAX_ROTATION - MIN_ROTATION));
		
		public function AsteroidModel()
		{
			width = height = MIN_RADIUS + (Math.random() * (MAX_RADIUS - MIN_RADIUS));
		}
		
		public override function get velocity():Number
		{
			return _velocity;
		}
		
		public override function get rotation():Number
		{
			return _rotation;
		}
		
		public override function set rotation(value:Number):void
		{
			throw new IllegalOperationError('Property is ready-only');
		}
		
		public function get mass():Number
		{
			return Math.max(width, height);
		}
	}
}
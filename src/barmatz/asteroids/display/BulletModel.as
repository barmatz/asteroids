package barmatz.asteroids.display
{
	internal class BulletModel extends MovementModel
	{
		private var _velocity:Number = 15;
		
		public function BulletModel()
		{
			width = 15;
			height = 3;
		}
		
		public override function get velocity():Number
		{
			return _velocity;
		}
	}
}
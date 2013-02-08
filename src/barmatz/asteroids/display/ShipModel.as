package barmatz.asteroids.display
{
	internal class ShipModel extends MovementModel
	{
		public static const RIGHT:String = 'right',
							LEFT:String = 'left';
		
		private var _rotate:String;
		
		public function ShipModel()
		{
			width = height = 20;
			acceleration = .3;
			minVelocity = -10;
			maxVelocity = 10;
		}
		
		public override function destroy():void
		{
			_rotate = null;
			super.destroy();
		}
		
		public function get rotate():String
		{
			return _rotate;
		}
		
		public function set rotate(value:String):void
		{
			_rotate = value;
		}
		
		public override function get rotation():Number
		{
			switch(rotate)
			{
				case RIGHT:
					super.rotation = super.rotation + 3;
					break;
				case LEFT:
					super.rotation = super.rotation - 3;
					break;
			}
			return super.rotation;
		}
	}
}
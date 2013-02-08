package barmatz.asteroids.managers
{
	import barmatz.mvc.AbstractModel;
	
	internal class FiringManagerModel extends AbstractModel
	{
		private var _delay:Number = 200;
		
		public function FiringManagerModel()
		{
		}
		
		public function destroy():void
		{
			_delay = NaN;
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
	}
}
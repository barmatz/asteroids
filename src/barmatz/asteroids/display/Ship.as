package barmatz.asteroids.display
{
	import barmatz.asteroids.ICollision;
	import barmatz.asteroids.managers.FiringManager;
	
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	
	[Event(name="hit", type="barmatz.asteroids.events.CollisionEvent")]
	
	public class Ship extends Component implements IDrawable, ICollision
	{
		private var controller:ShipController;
					
		public function Ship()
		{
			controller = new ShipController(this);
		}
		
		public function destroy():void
		{
			controller.destroy();
			controller = null;
		}
		
		public function draw(width:Number, height:Number):void
		{
			graphics.clear();
			graphics.lineStyle(1, 0x00FF00);
			graphics.beginFill(0);
			graphics.drawPath(
				new <int>[
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO
				],
				new <Number>[
					-width * .5, -height * .5,
					width * .5, 0,
					-width * .5, height * .5,
					-width * .25, 0,
					-width * .5, -height * .5
				]
			);
		}
		
		public function get firingManager():FiringManager
		{
			return controller.firingManager;
		}
		
		public function set firingManager(value:FiringManager):void
		{
			controller.firingManager = value;
		}
	}
}
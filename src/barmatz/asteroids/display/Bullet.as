package barmatz.asteroids.display
{
	import barmatz.asteroids.ICollision;
	
	import flash.display.GradientType;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	[Event(name="hit", type="barmatz.asteroids.events.CollisionEvent")]
	
	public class Bullet extends Component implements IDrawable, ICollision
	{
		private var controller:BulletController;
		
		public function Bullet()
		{
			controller = new BulletController(this);
		}
		
		public function destroy():void
		{
			controller = null;
		}
		
		public function draw(width:Number, height:Number):void
		{
			const MATRIX:Matrix = new Matrix();
			
			MATRIX.createGradientBox(width, height);
			
			graphics.clear();
			graphics.lineStyle(height);
			graphics.lineGradientStyle(GradientType.LINEAR, [0x00FF00, 0x00FF00], [0, 1], [0x00, 0xFF * .75], MATRIX);
			graphics.drawPath(
				new <int>[
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO
				],
				new <Number>[
					0, 0,
					width, 0
				]
			);
		}
		
		public override function set rotation(value:Number):void
		{
			super.rotation = controller.rotation = value;
		}
	}
}
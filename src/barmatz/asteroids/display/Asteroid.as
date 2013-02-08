package barmatz.asteroids.display
{
	import barmatz.asteroids.ICollision;
	
	import flash.display.GraphicsPathCommand;
	
	[Event(name="hit", type="barmatz.asteroids.events.CollisionEvent")]
	
	public class Asteroid extends Component implements IDrawable, ICollision
	{
		private var controller:AsteroidController;
		
		public function Asteroid()
		{
			controller = new AsteroidController(this);
		}
		
		public function draw(width:Number, height:Number):void
		{
			const COMMANDS:Vector.<int> = new Vector.<int>(),
				  DATA:Vector.<Number> = new Vector.<Number>();
				  
			var angle:uint = 0, radians:Number, x:Number, y:Number, initX:Number, initY:Number, lineInitiated:Boolean;
			
			while(angle < 360)
			{
				angle = Math.min(angle + Math.floor(10 + Math.random() * 90), 360);
				radians = MovementModel.degreesToRadians(angle);
				x = width * Math.cos(radians);
				y = height * Math.sin(radians);
				if(!lineInitiated)
				{
					COMMANDS.push(GraphicsPathCommand.MOVE_TO);
					lineInitiated = true;
					initX = x;
					initY = y;
				}
				else
					COMMANDS.push(GraphicsPathCommand.LINE_TO);
				DATA.push(x, y);
			}
			
			COMMANDS.push(GraphicsPathCommand.LINE_TO);
			DATA.push(initX, initY);
			
			graphics.clear();
			graphics.lineStyle(1, 0x00FF00);
			graphics.beginFill(0);
			graphics.drawPath(COMMANDS, DATA);
		}
	}
}
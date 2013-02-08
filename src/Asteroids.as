package
{
	import barmatz.asteroids.display.Ship;
	import barmatz.asteroids.managers.AsteroidsManager;
	import barmatz.asteroids.managers.CollisionDetectionManager;
	import barmatz.asteroids.managers.FiringManager;
	import barmatz.asteroids.managers.StageManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	[SWF(frameRate="60", width="800", height="600", backgroundColor="#000000")]
	
	public class Asteroids extends Sprite
	{
		public function Asteroids()
		{
			StageManager.reset(this);
			
			var cdm:CollisionDetectionManager = new CollisionDetectionManager(100);
			cdm.start();
			
			var am:AsteroidsManager = new AsteroidsManager(this);
			am.collisionDetectionManager = cdm;
			am.boundingBox = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			am.create(10);
			
			var ship:Ship = new Ship();
			ship.x = stage.stageWidth * .5 - ship.width * .5;
			ship.y = stage.stageHeight * .5 - ship.height * .5;
			ship.firingManager = new FiringManager(this, ship);
			ship.firingManager.collisionDetectionManager = cdm;
			addChild(ship);
			
			cdm.registerObject(ship);
			
			stage.addEventListener(Event.RESIZE, function(event:Event):void
			{
				am.boundingBox = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			});
		}
	}
}
package barmatz.asteroids.managers
{
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	public class StageManager
	{
		private static var instance:StageManager;
		
		private var _target:DisplayObject;
		
		public function StageManager(lock:Object = null)
		{
			if(!(lock is SingletoneLock))
				throw new IllegalOperationError('This is a singletone object and cannot be instatiated. Use getInstance().');
		}

		public static function reset(target:DisplayObject):void
		{
			getInstance().target = target;
			target.stage ? getInstance().resetStage() : target.addEventListener(Event.ADDED_TO_STAGE, onTargetAddedToStage, false, 0, true);
		}
		
		private static function getInstance():StageManager
		{
			if(!instance)
				instance = new StageManager(new SingletoneLock()); 
			return instance;
		}
		
		internal function resetStage():void
		{
			target.stage.align = StageAlign.TOP_LEFT;
			target.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private static function onTargetAddedToStage(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, onTargetAddedToStage);	
			getInstance().resetStage();
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target(value:DisplayObject):void
		{
			_target = value;
		}
	}
}

internal class SingletoneLock {}
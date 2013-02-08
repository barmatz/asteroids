package barmatz.asteroids.errors
{
	import flash.errors.IllegalOperationError;
	
	public class CollectionError extends IllegalOperationError
	{
		public function CollectionError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
		public function toString():String
		{
			return 'CollectionError #' + errorID + ': ' + message;
		}
	}
}
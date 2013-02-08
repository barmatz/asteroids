package barmatz.mvc
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class AbstractView extends EventDispatcher
	{
		private var _model:AbstractModel;
		
		public function AbstractView(model:AbstractModel)
		{
			_model = model;
		}
		
		protected function get model():AbstractModel
		{
			return _model;
		}
	}
}
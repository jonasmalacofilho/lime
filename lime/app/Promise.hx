package lime.app;


@:allow(lime.app.Future)


@:generic class Promise<T> {
	
	
	public var future (default, null):Future<T>;
	public var isComplete (get, null):Bool;
	public var isError (get, null):Bool;
	
	
	public function new () {
		
		future = new Future<T> ();
		
	}
	
	
	public function complete (data:T):Promise<T> {
		
		if (!future.isError) {
			
			future.isComplete = true;
			future.value = data;
			
			if (future.__completeListeners != null) {
				
				for (listener in future.__completeListeners) {
					
					listener (data);
					
				}
				
				future.__completeListeners = null;
				
			}
			
		}
		
		return this;
		
	}
	
	
	public function completeWith (future:Future<T>):Promise<T> {
		
		future.onComplete (complete);
		future.onError (error);
		future.onProgress (progress);
		
		return this;
		
	}
	
	
	
	public function error (msg:Dynamic):Promise<T> {
		
		if (!future.isComplete) {
			
			future.isError = true;
			future.error = msg;
			
			if (future.__errorListeners != null) {
				
				for (listener in future.__errorListeners) {
					
					listener (msg);
					
				}
				
				future.__errorListeners = null;
				
			}
			
		}
		
		return this;
		
	}
	
	
	public function progress (progress:Float):Promise<T> {
		
		if (!future.isError && !future.isComplete) {
			
			if (future.__progressListeners != null) {
				
				for (listener in future.__progressListeners) {
					
					listener (progress);
					
				}
				
			}
			
		}
		
		return this;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function get_isComplete ():Bool {
		
		return future.isComplete;
		
	}
	
	
	private function get_isError ():Bool {
		
		return future.isError;
		
	}
	
	
}
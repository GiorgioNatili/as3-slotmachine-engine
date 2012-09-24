package it.eurobet.core{

    import com.gnstudio.nabiro.utilities.logging.NabiroLogger;
    
    import flash.errors.IllegalOperationError;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    public  class  AbstractCommand extends EventDispatcher implements  ICommand {
    	
    	protected var allowUndo:Boolean = false;
    	protected var allowRedo:Boolean = false;
    	
        public function execute() :void {
        	
			trace("AbstractCommand: execute method not implemented.", this);
            
        }
        
        
        public function redo():void{
        	
        	if(!allowRedo){
        		
        		throw(new IllegalOperationError("Redo is not enabled by default!"));
        		
        	}
        	
        }
        
        public function undo():void{
        	
        	if(!allowUndo){
        		
        		throw(new IllegalOperationError("Undo is not enabled by default!"));
        		
        	}
        	
        }

        protected function onCommandComplete(params:* = null) :void {
        	
            dispatchEvent(new Event(Event.COMPLETE, true, true));
            
        }

        protected function onCommandFail(errorMessage :String = null) :void {
        	
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, true, true, errorMessage));
            
        }
    }
}

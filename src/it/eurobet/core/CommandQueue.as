package it.eurobet.core {
    
    import flash.events.ErrorEvent;
    import flash.events.Event;


    public class CommandQueue extends AbstractCommand {
		
		/**
		 * List of the commands to execute
		 */ 
        private var _commandList:Array;
        
        /**
         * Current index of the command
         */  
        private var _currentCommandIndex:int;
        
        /**
         * Performed command
         */ 
        private var _currentCommand:AbstractCommand;
        
        /**
         * Abort on fail flag
         */   
        private var _abortOnFail            :Boolean;
		
		/**
		 * Constructor
		 * Define the new instance with the option to abort the sequence if the queue fails
		 * Sampel usage:
		 * startSequence = new CommandQueue();
           startSequence.addCommand(

                new LoadSettingsCommand(configUrl),
                new SetStagePropertiesCommand(canvas)
               
            );
            startSequence.execute();
		 * @param abortOnFail Boolean
		 */ 
        public function CommandQueue(abortOnFail:Boolean = true) {
        	
        	_currentCommandIndex = 0;
        	
           	_abortOnFail = abortOnFail;
            _commandList = [];
            
        }
		
		/**
		 * Override of the execute method it's able to perform
		 * the execution of a list of commands
		 */ 
        override public function execute() :void {
			
			// If the current index is greater than the _commandList lenght
            if (_currentCommandIndex >= _commandList.length) {
				
				// Disopatch the complete event
                onCommandComplete();

            }else{
				
				// Define the command to execute --> the index is incrmented
                _currentCommand = _commandList[_currentCommandIndex++];
                
                // Define the listener for the curren command
                _currentCommand.addEventListener(Event.COMPLETE, onCurrentCommandExecuted);
                _currentCommand.addEventListener(ErrorEvent.ERROR, onCurrentCommandExecuted);
                
                // Execue the command
                _currentCommand.execute();
                
            }
        }
		
		/**
		 * Add a command or a list of command to the _commandList array
		 * @param command AbstractCommand
		 * @param commands rest
		 */ 
        public function addCommand(command:AbstractCommand, ...commands) :void {
        	
            _commandList = _commandList.concat([command].concat(commands));
            
        }
		
		/**
		 * Remove one or more commands from the queue
		 * @param command ICommand
		 * @param commands rest
		 */ 
        public function removeCommand(command:ICommand, ...commands) :void {
            
            // Remove the single command
           	commands.unshift(command);
            
            // And then move on the commands list
           	for (var i:int = 0; i < commands.length; i++) {
               
				for (var j: int = 0; j < _commandList.length; j++) {
                    
                    if (_commandList[j] === commands[i]) {
                        
                       _commandList.splice(i, 1);
                       break;
                    
                   }
               }
            }
        }
		
		/**
		 * Listener to the Event.COMPLETE and ErrorEvent.ERROR events
		 * it remove the previous defined listeners, reset the current command
		 * and hanlde the correct execution or the error on the execute
		 * @param e Event
		 */ 
        private function onCurrentCommandExecuted(event:Event):void {

            _currentCommand.removeEventListener(Event.COMPLETE, onCurrentCommandExecuted);

            _currentCommand.removeEventListener(ErrorEvent.ERROR, onCurrentCommandExecuted);

            _currentCommand = null;

            switch (event.type) {

                case Event.COMPLETE:
                	// Call the next command
                    execute();
                    break;

                case ErrorEvent.ERROR:
                
                	// If the queue needs to be stopped
                    if (_abortOnFail){
                    	
                    	// Dispatch the ErrorEvent
                    	onCommandFail((event as ErrorEvent).text);
                    	
                    }else{
                    	
                    	// Call the next command
                    	execute();
                    	
                    } 
                    break;

            }
        }
    }
}

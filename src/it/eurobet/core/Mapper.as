/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 2:57 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import flash.events.EventDispatcher;

    import it.eurobet.events.CommandCallEvent;
    import it.eurobet.events.InstructionEvent;

    import starling.events.Event;

    import flash.utils.getQualifiedClassName;
    import flash.utils.getQualifiedSuperclassName;
    import flash.utils.getDefinitionByName;

    import starling.events.EventDispatcher;

    public class Mapper {

        protected var elements:Array;
        protected var targets:Array;
        protected var target:flash.events.EventDispatcher;

        public function Mapper(tg:flash.events.EventDispatcher = null) {

            elements = [];
            targets = [];

            if(tg){

                registerTarget(tg);

            }

            target = tg;

        }

        public function registerTarget(tg:flash.events.EventDispatcher):void{

            if(target){

                target.removeEventListener(CommandCallEvent.COMMAND, onCommand);
                target.removeEventListener(InstructionEvent.PERFORM_INSTRUCTION, onInstruction);

                target = null;

            }

            target = tg;

            // Register the listeners for the COMMAND and for the MACRO
            target.addEventListener(CommandCallEvent.COMMAND, onCommand);

            // Register the listener for the instruction
            target.addEventListener(InstructionEvent.PERFORM_INSTRUCTION, onInstruction);

        }

        public function register(element:IWillBeObserved):IWillBeObserved{

            var missing:Boolean = true;
            var lim:int = elements.length;

            for(var i:int = 0; i < lim; i++){

                if(elements[i] == element){

                    missing = false;
                    break;

                }

            }

            // Only if the element is not already stored it will be added
            missing ? elements.push(element) : null;

            return element;

        }

        /**
         * Remove an element from the elements array and return the removed element
         * @param element IMapperCandidate
         * @return IMapperCandidate
         */
        public function unregister(element:IWillBeObserved):IWillBeObserved{

            var lim:int = elements.length;

            for(var i:int = 0; i < lim; i++){

                if(elements[i] == element){

                    elements.splice(i, 1);
                    break;

                }

            }

            return element;

        }

        /**
         * Receive and execute the command from the application
         * @param e CommandCallEvent
         */
        protected function onCommand(e:CommandCallEvent):void{

            try{

                (e.command as ICommand).execute();

            }catch(error:Error){

                trace("Error: " + error.message, this);

            }

        }

        public function addTarget(tg:starling.events.EventDispatcher):void {

            targets.push(tg);

            // Register the listeners for the COMMAND and for the MACRO
            tg.addEventListener(CommandCallEvent.COMMAND, onCommand);

            // Register the listener for the instruction
            tg.addEventListener(InstructionEvent.PERFORM_INSTRUCTION, onInstruction);

        }

        public function removeTarget(tg:starling.events.EventDispatcher):void {

            // Register the listeners for the COMMAND and for the MACRO
            tg.removeEventListener(CommandCallEvent.COMMAND, onCommand);

            // Register the listener for the instruction
            tg.removeEventListener(InstructionEvent.PERFORM_INSTRUCTION, onInstruction);

            var tot:int = targets.length;

            for(var i:int = 0; i < tot; i++){

                if(targets[i] == tg){

                    targets[i] = null;
                    targets.splice(i,  1);
                    break;

                }

            }

        }

        protected function onInstruction(e:*):void{

            var ClassReference:Class = getDefinitionByName(e.toPerform) as Class;
            var instance:Object = new ClassReference(e.target, e.parameters);

            // trace('onInstruction', e.toPerform, elements);

            for each (var item:IWillBeObserved in elements){

                if(item.hasEventListener(ClassReference.DO_HANDLE)){

                    item.dispatchEvent(instance as Event);

                }

            }

        }

    }
}

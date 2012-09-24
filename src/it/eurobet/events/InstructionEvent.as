/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 3:00 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.events {

    import starling.events.Event;

    public class InstructionEvent extends Event{

        public static const PERFORM_INSTRUCTION:String = "onPerformInstruction";
        protected var base:String = "";

        public var toPerform:String;
        public var parameters:*;
        public var isPreventable:Boolean;

        public function InstructionEvent(instruction:String, params:* = null, preventable:Boolean = false, bubbles:Boolean=true) {

            super(PERFORM_INSTRUCTION, bubbles);

            toPerform = base + instruction;
            parameters = params;
            isPreventable = preventable;

        }

        public function clone():Event {

            return new InstructionEvent(toPerform, parameters, isPreventable, bubbles);

        }

    }
}
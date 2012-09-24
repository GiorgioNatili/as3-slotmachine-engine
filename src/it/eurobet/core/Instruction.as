/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 3:20 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import starling.events.Event;

    public class Instruction extends Event{

        public static const DO_HANDLE:String = "onDoInstruction";

        protected var eType:String;

        public var parameters:*;
        public var origin:*;

        public function Instruction(o:*, t:String="", params:* = null, bubbles:Boolean=false){

            t == "" ? eType = DO_HANDLE : eType = t;

            super(eType || DO_HANDLE, bubbles);

            origin = o;
            parameters = params;
        }

        public function clone():Event {

            return new Instruction(origin, type, parameters);

        }
    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/16/12
 * Time: 9:29 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.events {

    import it.eurobet.core.ICommand;

    import starling.events.Event;

    public class CommandCallEvent extends Event{

        public static const COMMAND:String = "doCommand";
        public static const UNDO_COMMAND:String = "undoCommand";
        public static const REDO_COMMAND:String = "redoCommand";

        public var command:ICommand;
        public var nameSpace:Namespace;
        public var isPreventable:Boolean;

        public function CommandCallEvent(type:String, cm:ICommand = null, ns:Namespace= null, preventable:Boolean = false, bubbles:Boolean=true) {

            super (type, bubbles);

            command = cm;
            nameSpace = ns;
            isPreventable = preventable;

        }

        public function clone():Event {

            return new CommandCallEvent(type, command, nameSpace, isPreventable);

        }
    }
}


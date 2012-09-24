/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/13/12
 * Time: 11:38 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Instruction;
    import it.eurobet.core.TexturesLoader;

    import starling.events.Event;

    public class TexturesReadyToBuild extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onTexturesReadyToBuild";

        public function TexturesReadyToBuild(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        public function get textures():TexturesLoader{

            return parameters as TexturesLoader;

        }

        override public function clone():Event {

            return new TexturesReadyToBuild(origin, parameters);

        }
    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/11/12
 * Time: 9:17 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Instruction;

    import starling.events.Event;

    public class InitTransitions extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onInitTransitions";

        /**
         * @param o IEventDispatcher
         * @param params None.
         * @param bubbles Boolean
         * @param cancelable Boolean
         */

        public function InitTransitions(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        override public function clone():Event {

            return new InitTransitions(origin, parameters);

        }
    }
}

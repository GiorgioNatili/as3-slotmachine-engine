/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/19/12
 * Time: 9:40 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.Instruction;

    import starling.events.Event;

    public class UpdateReels extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onUpdateReels";

        /**
         * @param o IEventDispatcher
         * @param params None.
         * @param bubbles Boolean
         * @param cancelable Boolean
         */
        public function UpdateReels(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        /**
         * @private
         */
        override public function clone():Event {

            return new UpdateReels(origin, parameters);

        }
    }

}
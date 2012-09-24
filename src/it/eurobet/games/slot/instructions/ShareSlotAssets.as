/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/15/12
 * Time: 4:15 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Instruction;

    import starling.events.Event;

    public class ShareSlotAssets extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onShareSlotAssets";

        /**
         * @param o IEventDispatcher
         * @param params None.
         * @param bubbles Boolean
         * @param cancelable Boolean
         */
        public function ShareSlotAssets(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        override public function clone():Event {

            return new ShareSlotAssets(origin, parameters);

        }
    }
}

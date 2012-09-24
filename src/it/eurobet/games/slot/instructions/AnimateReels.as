/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/20/12
 * Time: 12:32 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.Instruction;
    import it.eurobet.games.slot.model.vos.TweenDescription;

    import starling.events.Event;

    public class AnimateReels extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onAnimateReels";

        /**
         * @param o IEventDispatcher
         * @param params None.
         * @param bubbles Boolean
         * @param cancelable Boolean
         */
        public function AnimateReels(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        public function get reelTransition():TweenDescription{

            return parameters[0] as TweenDescription;

        }

        public function get reelsOrder():Array{

            return parameters[1] as Array;

        }

        /**
         * @private
         */
        override public function clone():Event {

            return new AnimateReels(origin, parameters);

        }
    }

}

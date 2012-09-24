/**
 * Location:    it.eurobet.games.slot.instructions
 * User:        giorgionatili
 * Date:        9/19/12
 * Time:        3:11 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.Instruction;
    import it.eurobet.games.slot.model.vos.TweenDescription;

    import starling.events.Event;

    public class AnimateRenderData extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onAnimateRender";

        /**
         * @param o IEventDispatcher
         * @param params None.
         * @param bubbles Boolean
         * @param cancelable Boolean
         */
        public function AnimateRenderData(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        public function get limit():Number{

            return parameters[0] as Number;

        }

        public function get reelID():int{

            return parameters[2] as int;

        }

        public function get reelTransition():TweenDescription{

            return parameters[1] as TweenDescription;

        }

        /**
         * @private
         */
        override public function clone():Event {

            return new AnimateSymbol(origin, parameters);

        }
    }
}

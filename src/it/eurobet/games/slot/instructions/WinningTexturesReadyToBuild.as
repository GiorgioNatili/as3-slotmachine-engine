/**
 * Location:    it.eurobet.games.slot.instructions
 * User:        giorgionatili
 * Date:        11/3/12
 * Time:        12:36 AM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Instruction;
    import it.eurobet.core.TexturesLoader;

    import starling.events.Event;

    public class WinningTexturesReadyToBuild extends Instruction{

        /**
         * @private
         * Define the event type.
         *
         * <p>Use DO_HANDLE constant to listen for the instruction.</p>
         */
        public static const DO_HANDLE:String = "onWinningTexturesReadyToBuild";

        public function WinningTexturesReadyToBuild(o:*, params:* = null, bubbles:Boolean = false) {

            super(o, DO_HANDLE, params, bubbles);

        }

        public function get textures():TexturesLoader{

            return parameters as TexturesLoader;

        }

        override public function clone():Event {

            return new WinningTexturesReadyToBuild(origin, parameters);

        }
    }
}




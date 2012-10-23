/**
 * Location:    it.eurobet.games.slot.view.reels.events
 * User:        giorgionatili
 * Date:        9/19/12
 * Time:        4:58 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.view.reels.events {

    import starling.events.Event;

    public class ReelPhase extends Event{

        public static const ADDED_TO_QUEUE:String = 'onAddedToQueue';
        public static const PROCESS_QUEUE:String = 'onProcessTheQueue';
        public static const MOVING:String = 'onMoving';
        public static const INIT_MOVING:String = 'onInitMoving';
        public static const END_MOVING:String = 'onEndMoving';

        public var startingY:Number;

        public function ReelPhase(type:String, bubbles:Boolean = true, startY:Number = NaN){

           super (type, bubbles);

           startingY = startY;

        }
    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 11:03 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.events {

    import starling.events.Event;

    public class MouseEvent extends Event{

        public static const ROLL_OVER:String = 'onStarlingRollOver';
        public static const PRESS:String = 'onStarlingPress';
        public static const CLICK:String = 'onStarlingClick';
        public static const ROLL_OUT:String = 'onStarlingRollout';

        public function MouseEvent(type:String,bubbles:Boolean = false) {

            super(type,  bubbles);

        }

    }
}

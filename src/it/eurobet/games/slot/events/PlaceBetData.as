/**
 * Location:    it.eurobet.games.slot.events
 * User:        giorgionatili
 * Date:        10/23/12
 * Time:        4:52 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.events {

    import flash.events.Event;

    public class PlaceBetData extends Event{

        public static const READY:String = "onPlaceBetDataReady";
        public static const FAULT:String = "onPlaceBetDataFault";

        public function PlaceBetData(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {

            super(type,  bubbles, cancelable);

        }

        override public function clone():Event {

            return new DataEvent(type,  bubbles, cancelable);

        }

    }
}

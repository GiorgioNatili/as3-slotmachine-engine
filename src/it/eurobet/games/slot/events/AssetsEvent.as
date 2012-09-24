/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/14/12
 * Time: 3:04 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.events {

    import flash.events.Event;

    public class AssetsEvent extends Event{

        public static const ASSETS_READY:String = 'onAssetsReady';
        public static const ASSETS_FAULT:String = 'onAssetsFault';

        public function AssetsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {

            super (type, bubbles, cancelable);

        }

        override public function clone():Event {

            return new AssetsEvent(type, bubbles, cancelable);

        }
    }
}

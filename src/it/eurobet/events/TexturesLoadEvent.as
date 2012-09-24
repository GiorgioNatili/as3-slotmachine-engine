/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/12/12
 * Time: 9:59 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.events {

    import flash.events.Event;

    public class TexturesLoadEvent extends Event{

        public static const INFO_LOADED:String = 'onInfoLoaded';
        public static const INFO_LOADING_ERROR:String = 'onInfoLoadingError';
        public static const SOURCE_LOADED:String = 'onSourceLoaded';
        public static const SOURCE_LOADING_ERROR:String = 'onSourceLoadingError';
        public static const TEXTURES_DATA_READY:String = 'onTexturesDataReady';
        public static const TEXTURES_READY:String = 'onTexturesReady';

        public function TexturesLoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {

            super(type, bubbles, cancelable);

        }

        override public function clone():Event {

            return new TexturesLoadEvent(type, bubbles, cancelable);

        }
    }
}

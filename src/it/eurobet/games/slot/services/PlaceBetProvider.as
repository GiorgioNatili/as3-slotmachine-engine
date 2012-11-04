/**
 * Location:    it.eurobet.games.slot.services
 * User:        giorgionatili
 * Date:        10/23/12
 * Time:        4:43 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.services {

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import it.eurobet.games.slot.events.PlaceBetData;

    public class PlaceBetProvider implements IEventDispatcher{

        private var eventDispatcher:EventDispatcher;
        private var _source:String;
        private var _winningItems:Array;
        private var _winningLine:int;

        public function PlaceBetProvider(source:String) {

            eventDispatcher = new EventDispatcher(this);

            _source = source;

        }

        public function load(source:String = null):void {

            var url:URLRequest = new URLRequest(source || _source);

            var loader:URLLoader = new URLLoader();

            loader.addEventListener(Event.COMPLETE, onPlaceBetReady);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onPlaceBetFault);

            loader.load(url);

        }

        private function onPlaceBetFault(event:IOErrorEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);

            dispatchEvent(new PlaceBetData(PlaceBetData.FAULT));

        }

        private function onPlaceBetReady(event:Event):void {

            event.target.removeEventListener(event.type, arguments.callee);

            var data:XML = new XML(event.target.data);

            _winningItems = data.@RESULT.toXMLString().split(',');
            _winningLine = int(data.WINLINE.@ID.toXMLString())

            dispatchEvent(new PlaceBetData(PlaceBetData.READY));

        }

        public function get winningLine():int{

            return _winningLine;

        }

        public function get winningItems():Array {

            return _winningItems;

        }

        /******************************************
         * IEventDispatcher Implementation
         ******************************************/

        public function hasEventListener(type:String):Boolean {

            return eventDispatcher.hasEventListener(type);

        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {

            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);

        }

        public function dispatchEvent(event:Event):Boolean {

            return eventDispatcher.dispatchEvent(event);

        }

        public function willTrigger(type:String):Boolean {

            return eventDispatcher.willTrigger(type);

        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {

            eventDispatcher.removeEventListener(type, listener, useCapture);

        }

    }
}

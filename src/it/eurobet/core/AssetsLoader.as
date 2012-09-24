/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/15/12
 * Time: 2:09 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {
import flash.display.Loader;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

    import it.eurobet.games.slot.events.AssetsEvent;
    import it.eurobet.games.slot.events.AssetsEvent;
    import it.eurobet.games.slot.events.AssetsEvent;

    public class AssetsLoader implements IEventDispatcher{

    private var eventDispatcher:EventDispatcher;
    private var _assets:Loader;

    public function AssetsLoader(path:String) {

        _assets = new Loader();

        eventDispatcher = new EventDispatcher(this);

        var url:URLRequest = new URLRequest(path);
        var loader:URLLoader = new URLLoader();

        loader.dataFormat = URLLoaderDataFormat.BINARY;
        loader.addEventListener(Event.COMPLETE, onAssetsReady);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onAssetsFailure);

        loader.load(url);

    }

    private function onAssetsFailure(event:IOErrorEvent):void {

        event.target.removeEventListener(event.type, arguments.callee);

        dispatchEvent(new AssetsEvent(AssetsEvent.ASSETS_FAULT));

    }

    private function onAssetsReady(event:Event):void {

        event.target.removeEventListener(event.type, arguments.callee);

        var currentData:ByteArray = event.target.data as ByteArray;
        var context:LoaderContext = new LoaderContext(false);

        _assets.contentLoaderInfo.addEventListener(Event.COMPLETE, onBytesReady)
        _assets.loadBytes(currentData, context);

    }

    private function onBytesReady(event:Event):void {

        event.target.removeEventListener(event.type, arguments.callee);

        dispatchEvent(new AssetsEvent(AssetsEvent.ASSETS_READY));

    }

    public function get assets():Loader{

        return _assets;

    }

    /************************************
     * IEventDispatcher immplementation
     *************************************/
    public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void{

        eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);

    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void	{

        eventDispatcher.removeEventListener(type, listener, useCapture);

    }

    public function dispatchEvent(event:Event):Boolean {

        return eventDispatcher.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean {

        return eventDispatcher.hasEventListener(type);
    }

    public function willTrigger(type:String):Boolean {

        return eventDispatcher.willTrigger(type);

    }
}
}

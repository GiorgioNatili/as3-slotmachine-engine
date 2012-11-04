/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/6/12
 * Time: 1:46 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.core {
import com.gnstudio.nabiro.mvp.core.Configurator;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.System;

import it.eurobet.games.slot.events.DataEvent;

import it.eurobet.games.slot.model.vos.GridInfo;

public class AppConfig implements IConfigApp{


    private var eventDispatcher:EventDispatcher;
    private var configData:XMLList;

    public function AppConfig(file:String) {

        eventDispatcher = new EventDispatcher(this);

        var url:URLRequest = new URLRequest(file);

        var loader:URLLoader = new URLLoader();

        loader.addEventListener(Event.COMPLETE, onConfigReady);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onConfigFault);

        loader.load(url);

    }

    private function onConfigReady(event:Event):void {

        event.target.removeEventListener(event.type, arguments.callee);

        var data:XML = XML(event.target.data);
        configData = data.property;

        // System.disposeXML(data);

        dispatchEvent(new DataEvent(DataEvent.CONFIG_READY));

    }

    private function onConfigFault(event:IOErrorEvent):void {

        event.target.removeEventListener(event.type, arguments.callee);

        dispatchEvent(new DataEvent(DataEvent.CONFIG_FAULT));

        trace("file not loaded");

    }


    public function get assetsPath():String {

        return configData.(@id == 'assetsPath').@value.toXMLString();

    }

    public function get assetsFile():String {

        return configData.(@id == 'assetsFile').@value.toXMLString();

    }

    public function get winningLineRandomColor():Boolean{

        var value:Boolean;
        var returned:String = configData.(@id == 'winningLineColor').@random.toXMLString();

        returned == 'true' ? value = true : value = false;

        return value;

    }

    public function get winningLineColor():uint{

        return uint(configData.(@id == 'winningLineColor').@value.toXMLString());

    }

    public function get multistage():Boolean {

        var value:Boolean;
        var returned:String = configData.(@id == 'isMultistage').@value.toXMLString();

        returned == 'true' ? value = true : value = false;

        return value;

    }

    public function get type():String {

        return configData.(@id == 'type').@value.toXMLString();

    }

    public function get symbolsTexture():String {

        return configData.(@id == 'symbolsTexture').@value.toXMLString();

    }

    public function get symbolsTextureInfo():String {

        return configData.(@id == 'symbolsTextureInfo').@value.toXMLString();

    }

    public function get winningLinesTexture():String {

        return configData.(@id == 'winningLinesTexture').@value.toXMLString();

    }

    public function get winningLinesTextureInfo():String {

        return configData.(@id == 'winningLinesTextureInfo').@value.toXMLString();

    }

    public function get background():String {

        return configData.(@id == 'background').@value.toXMLString();

    }

    public function get transitions():XMLList{

        return configData.(@id == 'transitions').transition;

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

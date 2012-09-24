/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/6/12
 * Time: 2:57 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {
import flash.errors.IOError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.System;

import it.eurobet.games.slot.events.DataEvent;

import it.eurobet.games.slot.model.vos.GridInfo;

public class DataReader implements IEventDispatcher{

    private var eventDispatcher:EventDispatcher;

    private var grid:GridInfo
    private var reels:XMLList;
    private var winLines:String;

    public function DataReader(file:String) {

        eventDispatcher = new EventDispatcher(this);
        grid = new GridInfo();

        var url:URLRequest = new URLRequest(file);

        var loader:URLLoader = new URLLoader();

        loader.addEventListener(Event.COMPLETE, onDataReady);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onDataFault);

        loader.load(url);

    }

    private function onDataFault(event:IOErrorEvent):void {

        event.target.removeEventListener(event.type, arguments.callee);

        dispatchEvent(new DataEvent(DataEvent.DATA_FAULT));

    }

    private function onDataReady(event:Event):void {

        event.target.removeEventListener(event.type, arguments.callee);

        var data:XML = XML(event.target.data);

        reels = data.REEL;
        winLines = data.WINLINES.@COORD.toXMLString();

        grid.columns =  data.@NUMREELS.toXMLString();
        grid.rows =     data.@NUMROWS.toXMLString();

        System.disposeXML(data);

        dispatchEvent(new DataEvent(DataEvent.DATA_READY));

    }

    public function get gridInfo():GridInfo {

        return grid;

    }

    public function get winningLines():String{

        return winLines;

    }

    public function get loadedReels():XMLList{

        return reels;

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

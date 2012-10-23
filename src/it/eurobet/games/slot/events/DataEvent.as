/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/6/12
 * Time: 2:20 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.events {
import flash.events.Event;

public class DataEvent extends Event{

    public static const CONFIG_READY:String = "onConfigReady";
    public static const CONFIG_FAULT:String = "onConfigFault";
    public static const DATA_READY:String = "onDataReady";
    public static const DATA_FAULT:String = "onDataFault";
    public static const BET_DATA_FAULT:String = "onBetDataFault";

    public function DataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {

        super(type,  bubbles, cancelable);

    }

    override public function clone():Event {

        return new DataEvent(type,  bubbles, cancelable);

    }
}
}

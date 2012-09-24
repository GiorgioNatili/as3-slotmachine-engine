/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 3:05 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import starling.events.Event;

    public interface IEventDispatcher {

        function dispatchEvent(event:Event):void;
        function removeEventListener(type:String, listener:Function):void;
        function addEventListener(type:String, listener:Function):void;
        function hasEventListener(type:String):Boolean;

    }
}

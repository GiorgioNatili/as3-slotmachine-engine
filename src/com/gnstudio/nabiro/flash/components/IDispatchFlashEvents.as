/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 11:56 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gnstudio.nabiro.flash.components {

    import flash.events.Event;

    public interface IDispatchFlashEvents {

        function addFlashEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void;
        function removeFlashEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        function dispatchFlashEvent(event:Event):Boolean
        function hasFlashEventListener(type:String):Boolean
        function willTriggerFlashEvent(type:String):Boolean

    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 12:27 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gnstudio.nabiro.flash.components {

    import flash.events.Event;
    import flash.events.EventDispatcher;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    public class SmartStarlingSprite extends Sprite implements IDispatchFlashEvents{

        private var eventDispatcher:flash.events.EventDispatcher;

        public function SmartStarlingSprite() {

            addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemovedFromStage);

        }

        protected function init():void{



        }

        protected function resize():void{



        }

        private function onAddedToStage(e:starling.events.Event):void{

            e.target.removeEventListener(e.type, arguments.callee);

            stage.addEventListener(starling.events.Event.RESIZE, onStageResize);
            eventDispatcher =  new flash.events.EventDispatcher(Starling.current.nativeOverlay)      ;

            init();

        }

        private function onRemovedFromStage(e:starling.events.Event):void{

            e.target.removeEventListener(e.type, arguments.callee);

            dispose();

        }

        private function onStageResize(e:starling.events.Event):void{

            resize();

        }

        /************************************
         * IDispatchFlashEvents immplementation
         *************************************/
        public function addFlashEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void{

            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);

        }

        public function removeFlashEventListener(type:String, listener:Function, useCapture:Boolean=false):void	{

            eventDispatcher.removeEventListener(type, listener, useCapture);

        }

        public function dispatchFlashEvent(event:flash.events.Event):Boolean {

            return Starling.current.nativeOverlay.dispatchEvent(event);

        }

        public function hasFlashEventListener(type:String):Boolean {

            return eventDispatcher.hasEventListener(type);
        }

        public function willTriggerFlashEvent(type:String):Boolean {

            return eventDispatcher.willTrigger(type);

        }

    }
}

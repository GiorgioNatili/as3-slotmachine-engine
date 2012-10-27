/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/11/12
 * Time: 8:25 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {

    import com.greensock.TweenMax;
    import com.greensock.easing.Back;
    import com.greensock.easing.Linear;
    import com.greensock.easing.Bounce;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.sampler.ClassFactory;
    import flash.utils.getDefinitionByName;

    import it.eurobet.games.slot.model.vos.TweenDescription;

    import starling.animation.Transitions;
    import starling.animation.Tween;

    public class TransitionProvider implements IEventDispatcher{

        private var eventDispatcher:EventDispatcher;

        private var transitionsInfo:XMLList;
        private const REEL:String = 'reel';
        private const WINNING_SYMBOL:String = 'winningSymbol';
        private const WINNING_LINE:String = 'winningLine';

        // Index 0 and 1 are reserved, add new class references only at the end of the array
        private const TRANSITIONS:Array = [Tween, Transitions, TweenMax, Back, Linear, Bounce];

        public function TransitionProvider(data:XMLList) {

            eventDispatcher = new EventDispatcher(this);

            transitionsInfo = data;

        }

        private function buildReel(id:String):TweenDescription{

            var current:XML = transitionsInfo.(@id == id)[0];

            var description:TweenDescription = new TweenDescription();

            description.speed = Number(current.@speed.toXMLString());
            description.minDuration = int(current.@duration.toXMLString());
            current.@random.toXMLString() == 'true' ? description.isRandom = true : description.isRandom = false;
            description.easing = parseEasing(current.@easing.toXMLString(), current.@ease.toXMLString());
            description.tweener = parseTweener(current.@plugin.toXMLString());

            return description;

        }

        private function parseTweener(alias:String):Class{

            var clazz:Class;

            try{

                clazz = getDefinitionByName(alias) as Class;

            }catch(error:Error){

                clazz = TRANSITIONS[0];

            }

            return clazz;

        }

        private function parseEasing(alias:String, prop:String):Function{

            var clazz:Class

            try{

                clazz = getDefinitionByName(alias) as Class;

            }catch (error:Error){

                clazz = TRANSITIONS[1];

            }

            return clazz[prop] as Function;
        }

        public function get winningSymbolTransition():TweenDescription{

            return buildReel(WINNING_SYMBOL);


        }

        public function get winningLineTransition():TweenDescription{

            return buildReel(WINNING_LINE);

        }

        public function get reelTransition():TweenDescription{

            return buildReel(REEL);

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

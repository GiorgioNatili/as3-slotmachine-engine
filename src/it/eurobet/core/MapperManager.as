/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 3:24 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import starling.display.DisplayObject;
    import starling.events.Event;

    public class MapperManager {

        private var _listeners:Vector.<DisplayObject>;
        private var _mapper:Mapper;

        public function MapperManager(listeners:Vector.<DisplayObject>, target:Mapper)	{

            _listeners = listeners;
            _mapper = target;

        }

        public function initialize():void{

            for(var i:int = 0; i < _listeners.length; i++){

                _listeners[i].addEventListener(Event.ADDED, onItemAdded)
                _listeners[i].addEventListener(Event.REMOVED, onItemRemoved)

            }

        }

        public function reset():void{

            for(var i:int = 0; i < _listeners.length; i++){

                _listeners[i].removeEventListener(Event.ADDED, onItemAdded)
                _listeners[i].removeEventListener(Event.REMOVED, onItemRemoved)

            }

        }

        /**
         * Listeners used in order to register the IMapperCandidate visual component,
         * these components can receive the result of a query automatically
         * @param e Event
         */
        protected function onItemAdded(e:Event):void{

            if(e.target is IWillBeObserved){

                _mapper.register(e.target as IWillBeObserved);

            }

        }

        protected function onItemRemoved(e:Event):void{

            if(e.target is IWillBeObserved){

                _mapper.unregister(e.target as IWillBeObserved);

            }

        }
    }
}

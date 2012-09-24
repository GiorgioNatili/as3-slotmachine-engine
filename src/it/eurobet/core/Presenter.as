/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 3:54 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import flash.display.DisplayObject;

    import it.eurobet.events.InstructionEvent;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class Presenter extends EventDispatcher{

        protected var _view:IStarlingView;
        protected var _origin:DisplayObject;

        public function Presenter(v:IStarlingView) {

            _view = v;

        }

    }
}

/**
 * Location:    it.eurobet.games.slot.view.reels.components
 * User:        giorgionatili
 * Date:        8/20/12
 * Time:        12:04 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.view.reels.components {

    import com.gnstudio.nabiro.flash.components.SmartStarlingSprite;

    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.games.slot.instructions.AnimateRenderData;
    import it.eurobet.games.slot.instructions.AnimateSymbol;
    import it.eurobet.games.slot.view.reels.events.ReelPhase;

    import starling.display.Quad;
    import starling.events.Event;

    public class ReelItemContainer extends SmartStarlingSprite implements IWillBeObserved {

        private const SPEED:int = 18;

        private var reelItems:Vector.<ReelItem>;
        private var _initialY:int = 0;
        private var _limit:Number;

        private var _speed:Number;
        private var isRandom:Boolean;
        private var minDuration:int;
        private var _processQueue:Boolean;
        private var _status:String;

        public static const IS_MOVING:String = 'isMoving';
        public static const IS_QUEUED:String = 'isQueued';
        public static const IS_PAUSED:String = 'isPaused';

        public function ReelItemContainer(items:Vector.<ReelItem>) {

            reelItems = items;

            _status = IS_QUEUED;

            addEventListener(AnimateRenderData.DO_HANDLE, onAnimateRenderer);
            addEventListener(ReelPhase.MOVING, onReStartMoving);
            addEventListener(ReelPhase.INIT_MOVING, initMoving);

        }

        private function onAnimateRenderer(instruction:AnimateRenderData):void {

            _speed = instruction.reelTransition.speed;
            minDuration = instruction.reelTransition.minDuration;
            isRandom = instruction.reelTransition.isRandom;

        }

        private function initMoving(event:ReelPhase):void{

            _status = IS_MOVING;
            addEventListener(Event.ENTER_FRAME, onMoving);

        }

        private function onReStartMoving(event:ReelPhase):void{

            y = event.startingY;

            visible = true;
            _status = IS_MOVING;

            addEventListener(Event.ENTER_FRAME, onMoving);

        }

        private function onMoving(event:Event):void {

            event.stopImmediatePropagation();

            move();

        }

        public function move():void {

            this.y += speed;

            if (this.y > _limit - height) {

                dispatchEvent(new ReelPhase(ReelPhase.PROCESS_QUEUE));

            }

            if (this.y > _limit) {

                _status = IS_PAUSED;
                visible = false;
                removeEventListener(Event.ENTER_FRAME, onMoving);
                dispatchEvent(new ReelPhase(ReelPhase.PROCESS_QUEUE));

            }

        }

        override protected function init():void {

            super.init();

            drawReelItems();

        }

        override public function get height():Number{

            var value:Number = 0;

            if(stage){

                value = super.height;

            }else{

                var tot:int = reelItems.length;

                for (var i:int = 0; i < tot; i++) {

                    value += reelItems[i].height;

                }

            }

            return value;

        }

        private function drawReelItems():void{

            var tot:int = reelItems.length;

            for (var i:int = 0; i < tot; i++) {

                reelItems[i].y = i * reelItems[i].height;
                addChild(reelItems[i]);

            }

            flatten();

        }

        public function set limit(value:Number):void{

            if(!_limit || value != _limit){

                _limit = value;

            }

        }

        public function set speed(value:Number):void{

            _speed = value;

        }

        public function get speed():Number {

            return _speed || SPEED;

        }

        public function set initialY(value:int):void {

            _initialY = value;

        }

        public function get status():String{

            return _status;

        }

        public function get itemHeight():Number {

            return reelItems[0].height;

        }

        public function set processQueue(value:Boolean):void {

            _processQueue = value;

        }
    }

}
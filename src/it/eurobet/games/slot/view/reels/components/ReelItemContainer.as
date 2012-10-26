/**
 * Location:    it.eurobet.games.slot.view.reels.components
 * User:        giorgionatili
 * Date:        8/20/12
 * Time:        12:04 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.view.reels.components {

    import com.gnstudio.nabiro.flash.components.SmartStarlingSprite;
    import com.greensock.TimelineMax;

    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.games.slot.instructions.AnimateRenderData;
    import it.eurobet.games.slot.instructions.AnimateSymbol;
    import it.eurobet.games.slot.model.vos.TweenDescription;
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
        private var _id:String;

        public static const IS_MOVING:String = 'isMoving';
        public static const IS_QUEUED:String = 'iQueued';
        public static const IS_PAUSED:String = 'isPaused';

        private var _itemDirty:Boolean;

        public function ReelItemContainer(items:Vector.<ReelItem>) {

            reelItems = items;

            _status = IS_QUEUED;

            addEventListener(AnimateRenderData.DO_HANDLE, onAnimationData);
            addEventListener(ReelPhase.MOVING, onReStartMoving);
            addEventListener(ReelPhase.INIT_MOVING, initMoving);
            addEventListener(ReelPhase.END_MOVING, onEndMoving);

        }

        private function onEndMoving(event:ReelPhase):void {

            addEventListener(Event.ENTER_FRAME, endMoving);

        }

        private function endMoving(event:Event):void {

            this.y += speed;

            if (this.y > -height) {

                removeEventListener(Event.ENTER_FRAME, endMoving);
                dispatchEvent(new ReelPhase(ReelPhase.FINAL_TRANSITION));

            }

        }

        private function onTweenComplete():void {

        }

        private function onAnimationData(instruction:AnimateRenderData):void {

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

            if(!_processQueue)return;

            if(_itemDirty && this.y > _limit){

                removeEventListener(Event.ENTER_FRAME, onMoving);
                dispatchEvent(new ReelPhase(ReelPhase.REMOVE_FROM_QUEUE));

                visible = false;
                removeFromParent(true);

            }

            if (this.y > _limit - height && !_itemDirty) {

                dispatchEvent(new ReelPhase(ReelPhase.PROCESS_QUEUE));

            }

            if (this.y > _limit) {

                _status = IS_PAUSED;
                visible = false;
                removeEventListener(Event.ENTER_FRAME, onMoving);

                dispatchEvent(new ReelPhase(ReelPhase.PROCESS_QUEUE));

            }

        }

        public function pause(toggle:Boolean = true):void{

            if(toggle){

                _status = IS_PAUSED;
                removeEventListener(Event.ENTER_FRAME, onMoving);

            }else{

                _status = IS_MOVING;
                addEventListener(Event.ENTER_FRAME, onMoving);

            }

        }

        public function remove():void{

            _itemDirty = true;

        }

        public function removeNow():void{

            removeEventListener(Event.ENTER_FRAME, onMoving);
            dispatchEvent(new ReelPhase(ReelPhase.REMOVE_FROM_QUEUE));

            removeFromParent(true);

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

        public function get id():String {
            return _id;
        }

        public function set id(value:String):void {
            _id = value;
        }
    }

}

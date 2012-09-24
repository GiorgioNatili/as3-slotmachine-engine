/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/11/12
 * Time: 8:56 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.model.vos {

    public class TweenDescription {

        private var _minDuration:int;
        private var _isRandom:Boolean;
        private var _easing:Function;
        private var _tweener:Class;
        private var _speed:Number;
        public function set speed(value:Number):void {
            _speed = value;
        }

        public function TweenDescription() {
        }

        public function get tweener():Class {
            return _tweener;
        }

        public function set tweener(value:Class):void {
            _tweener = value;
        }

        public function get easing():Function {
            return _easing;
        }

        public function set easing(value:Function):void {
            _easing = value;
        }

        public function get isRandom():Boolean {
            return _isRandom;
        }

        public function set isRandom(value:Boolean):void {
            _isRandom = value;
        }

        public function get minDuration():int {
            return _minDuration;
        }

        public function set minDuration(value:int):void {
            _minDuration = value;
        }

        public function get speed():Number {
            return _speed;
        }
    }
}

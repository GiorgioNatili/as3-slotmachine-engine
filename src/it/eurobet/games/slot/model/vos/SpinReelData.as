/**
 * Location:    it.eurobet.games.slot.model.vos
 * User:        giorgionatili
 * Date:        8/20/12
 * Time:        7:51 AM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.model.vos {

    public class SpinReelData {

        private var _winning:Vector.<String>;
        private var _moving:Vector.<String>;
        private var _heading:Vector.<String>;
        private var _winningCoordinates:Coordinates;

        public function SpinReelData() {
        }

        public function get winning():Vector.<String> {
            return _winning;
        }

        public function set winning(value:Vector.<String>):void {
            _winning = value;
        }

        public function get moving():Vector.<String> {
            return _moving;
        }

        public function set moving(value:Vector.<String>):void {
            _moving = value;
        }

        public function get heading():Vector.<String> {
            return _heading;
        }

        public function set heading(value:Vector.<String>):void {
            _heading = value;
        }

        public function set winningCoordinates(winningCoordinates:Coordinates):void {
            _winningCoordinates = winningCoordinates;
        }

        public function get winningCoordinates():Coordinates {
            return _winningCoordinates;
        }
    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:50 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.model.vos {

public class Coordinates {

    private var _row:int;
    private var _line:int;

    public function Coordinates() {


    }

    public function get row():int {
        return _row;
    }

    public function set row(value:int):void {
        _row = value;
    }

    public function get line():int {
        return _line;
    }

    public function set line(value:int):void {
        _line = value;
    }
}
}

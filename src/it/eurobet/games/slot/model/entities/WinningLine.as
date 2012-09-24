/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:48 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.model.entities {
import it.eurobet.games.slot.model.vos.Coordinates;

public class WinningLine {

    private var _id:int;
    private var _coordinates:Vector.<Coordinates>;
    private var _color:uint;

    public function WinningLine() {

        _coordinates = new Vector.<Coordinates>();

    }

    public function get id():int {
        return _id;
    }

    public function set id(value:int):void {
        _id = value;
    }

    public function get coordinates():Vector.<Coordinates> {
        return _coordinates;
    }

    public function set coordinates(value:Vector.<Coordinates>):void {
        _coordinates = value;
    }

    public function get color():uint {
        return _color;
    }

    public function set color(value:uint):void {
        _color = value;
    }
}
}

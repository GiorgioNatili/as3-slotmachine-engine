/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:20 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.model.entities {

public class Reel {

    private var _id:int;
    private var _sequence:String;

    public function Reel() {


    }

    public function get sequence():String {
        return _sequence;
    }

    public function set sequence(value:String):void {
        _sequence = value;
    }

    public function get id():int {
        return _id;
    }

    public function set id(value:int):void {
        _id = value;
    }


}
}

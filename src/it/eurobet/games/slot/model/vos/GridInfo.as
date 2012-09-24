/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/6/12
 * Time: 2:16 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.model.vos {

public class GridInfo {

    private var _rows:int;
    private var _columns:int;

    public function GridInfo() {


    }

    public function get columns():int {
        return _columns;
    }

    public function set columns(value:int):void {
        _columns = value;
    }

    public function get rows():int {
        return _rows;
    }

    public function set rows(value:int):void {
        _rows = value;
    }
}
}

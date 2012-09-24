/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 11:56 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services.parsers {
public class OddRowParser extends RowParser{

    public function OddRowParser(index:int = int.MAX_VALUE) {

        super(index);

    }

    override public function getWinningSequence(data:Array, index:int, tot:int):Vector.<String>{

        var value:Vector.<String> = new Vector.<String>();

        var items:int = data.length;
        var shift:int = (tot - (tot % 2)) / 2;
        var start:int = getStartIndex(index, shift,  items);

        for(var i:int = start; i < (start + tot); i++){

            var indexToGo:int = (i >= items) ? (i - items) : i;
            value.push(data[indexToGo]);

        }

        lastIndex = indexToGo + 1;

        return value;

    }

}
}

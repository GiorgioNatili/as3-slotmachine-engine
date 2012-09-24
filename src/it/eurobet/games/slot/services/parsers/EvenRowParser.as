/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/19/12
 * Time: 1:43 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services.parsers {
import it.eurobet.games.slot.services.IProcessSequence;

public class EvenRowParser extends RowParser{

    public function EvenRowParser(index:int = int.MAX_VALUE) {

        super(index);

    }

    override public function getWinningSequence(data:Array, index:int, tot:int):Vector.<String>{

        var value:Vector.<String> = new Vector.<String>();

        var items:int = data.length;
        var shift:int = (tot / 2) - 1;
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

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/19/12
 * Time: 1:44 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services.parsers {
import it.eurobet.games.slot.services.IProcessSequence;

internal class RowParser implements IProcessSequence{

    protected var startIndex:int;
    protected var lastIndex:int;

    protected const SEPARATOR:String = ',';
    protected const ITEMS:int = 5;
    protected const MULTIPLIER:int = 1;

    public function RowParser(index:int = int.MAX_VALUE) {

        startIndex = index;

    }

    public function getWinningSequence(raw:Array, index:int, tot:int):Vector.<String> {

        throw new Error('\tError: Override the "getWinningSequence" in the child class.');

    }

    public function getMovingSequence(raw:Array, tot:int):Vector.<String>{

        try{

            var value:Vector.<String> = new Vector.<String>();
            var items:int = raw.length;

            for(var i:int = lastIndex; i < (lastIndex + tot) * MULTIPLIER; i++){

                var indexToGo:int = (i >= items) ? (i - items) : i;
                value.push(raw[indexToGo]);

            }

        }catch (error:Error){

            trace('\n\tERROR: The "lastIndex" property does\'nt contains any value!');

        }

        return value;

    }

    public function getSymbols(data:Array, items:int = int.MAX_VALUE):Vector.<String> {

        var value:Vector.<String> = new Vector.<String>();

        var tot:int = data.length;
        var totalItems:int = items;

        if(totalItems == int.MAX_VALUE){

            totalItems = ITEMS;

        }

        tot -= totalItems;

        var start:int;

        if(startIndex == int.MAX_VALUE){

            start = int(Math.random() * tot);

        }else{

            start = startIndex;

        }

        for(var i:int = start; i < (start + totalItems); i++){

            value.push(data[i]);

        }

        return value;

    }

    public function getWinningSymbols(raw:Array, index:int, tot:int):Vector.<String> {

        throw new Error('\tError: Override the "getWinningSymbols" in the child class.');

    }

    protected function getStartIndex(index:int, shift:int, items:int):int{

        var delta:int = index - shift;
        var value:int;

        if (delta >= 0) {

            value = delta

        }else{

            delta *= -1
            value = items - delta;
        }

        return value;

    }
}
}

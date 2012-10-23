/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 11:11 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {

public class ReelSymbolsProvider {

    // need to know the rows
    // Needs to know all the reels

    private const SEPARATOR:String = ',';

    private var symbolsParser:IProcessSequence;
    private var rawValue:String;
    private var _parsedValue:Array;

    private var winningSymbols:Array;
    private var winningIndex:int;
    private var winningItems:int;

    public function ReelSymbolsProvider(parser:IProcessSequence, value:String, winning:Array) {

        symbolsParser = parser;
        rawValue = value;
        winningSymbols = winning;

    }

    protected function get parsedValue():Array{

        if(!_parsedValue){

            _parsedValue = rawValue.split(SEPARATOR);

        }

        return _parsedValue;

    }

    // Return the complete sequence of the reel
    public function get all():Vector.<String>{

        var count:int = 0;

        var v:Vector.<String> = new Vector.<String>(parsedValue.length);

        for each(var symbol:String in parsedValue){

            v[count] = symbol;
            count++;

        }

        return v;

    }

    // Return the sequence from an ID to an index (the X symbols we need)
    public function currents(tot:int = int.MAX_VALUE):Vector.<String>{

        return symbolsParser.getSymbols(parsedValue, tot);

    }

    // Return the winning sequence given by an index and number of items needed
    public function winning(index:int, tot:int):Vector.<String>{

        winningIndex = index;
        winningItems = tot;

        return symbolsParser.getWinningSymbols(winningSymbols, winningIndex, winningItems);

    }

    public function get moving():Vector.<String>{

        return symbolsParser.getMovingSequence(parsedValue, winningItems);

    }

}
}

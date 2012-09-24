/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:36 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {
import it.eurobet.games.slot.model.entities.WinningLine;
import it.eurobet.games.slot.model.vos.Coordinates;
import it.eurobet.games.slot.model.vos.GridInfo;
import it.eurobet.games.slot.model.entities.Reel;

public class SlotDataProvider {

    private var _reels:Vector.<Reel>;
    private var _winningLines:Vector.<WinningLine>;
    private var _grid:GridInfo;

    private const SEPARATOR:String = '~';

    public function SlotDataProvider(data:DataReader) {

        _reels = new Vector.<Reel>();
        _winningLines = new Vector.<WinningLine>();

        parseReels(data.loadedReels);
        parseWinningLines(data.winningLines);

        _grid = data.gridInfo;

    }

    protected function parseReels(value:XMLList):void{

        for each (var item:XML in value){

            var reel:Reel = new Reel();

            reel.id = int(item.@ID);
            reel.sequence = item.@SEQ.toXMLString();

            _reels.push(reel);

        }
    }

    protected function parseWinningLines(value:String):void{

        var lines:Array = value.split(SEPARATOR);
        var total:int = lines.length;

        for(var i:int = 0; i < total; i++){

            var line:WinningLine = new WinningLine();

            line.id = i + 1;

            var coords:Array = lines[i].split(',');

            for each(var item:String in coords){

                var coordinates:Coordinates = readCoordinates(item);
                line.coordinates.push(coordinates);

            }

            _winningLines.push(line);

        }

    }

    private function readCoordinates(item:String):Coordinates {

        var coordinates:Coordinates = new Coordinates();

        coordinates.line = int(item.substr(0, 1));
        coordinates.row = int(item.substr(1, 1));

        return coordinates;

    }

    public function get reels():Vector.<Reel> {

        return _reels;

    }

    public function get winningLines():Vector.<WinningLine> {

        return _winningLines;

    }

    public function get grid():GridInfo {

        return _grid;

    }
}
}

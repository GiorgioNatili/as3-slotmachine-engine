/**
 * Location:    it.eurobet.games.slot.view.reels.helpers
 * User:        giorgionatili
 * Date:        11/2/12
 * Time:        9:24 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.view.reels.helpers {

    import it.eurobet.games.slot.model.entities.WinningLine;

    public class WinningLinesFinder {

        private var _lines:Vector.<WinningLine>;

        public function WinningLinesFinder(lines:Vector.<WinningLine>) {

             _lines = lines;

        }

        public function getLineByID(id:int):WinningLine{

            var value:WinningLine;

            for each(var item:WinningLine in _lines){

                if(item.id == id){

                    value = item;
                    break;

                }

            }
            return value;

        }
    }
}

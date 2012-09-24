/**
 * Location:    it.eurobet.games.slot.view.reels.helpers
 * User:        giorgionatili
 * Date:        8/20/12
 * Time:        12:09 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.games.slot.view.reels.helpers {

    import it.eurobet.games.slot.view.reels.components.ReelItem;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    public class CleanAndCloneItems {

        private var currentTarget:DisplayObjectContainer;
        private var _items:Vector.<ReelItem>;

        public function CleanAndCloneItems(tg:DisplayObjectContainer) {

            currentTarget = tg;
            _items = new Vector.<ReelItem>()

            parse();

        }

        private function parse():void{

            for(var i:int = 0; i < currentTarget.numChildren; i++){

                var item:DisplayObject = currentTarget.getChildAt(i);

                if(item is ReelItem){

                    _items.push(item);

                }

            }

        }

        public function getItems(clean:Boolean = false):Vector.<ReelItem>{

            if(clean){

                cleanItems();

            }

            return _items;

        }

        public function cleanItems():void {

            for each(var item:ReelItem in _items) {

                item.removeFromParent(true);

            }
        }
    }
}

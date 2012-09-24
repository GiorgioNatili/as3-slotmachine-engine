/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/19/12
 * Time: 9:48 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.slot.helpers {

    import starling.display.DisplayObject;
    import starling.display.Sprite;

    public class KeepOnTop {

        private var numChildren:int;
        private var container:Sprite;

        public function KeepOnTop(target:Sprite) {

            container = target;
            numChildren = container.numChildren;

        }

        public function keepOnTop(...rest):void {

            for each(var item:Sprite in rest){

                container.setChildIndex(item,  numChildren);

            }

        }
    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/14/12
 * Time: 2:03 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels.helpers {


import it.eurobet.games.slot.view.reels.components.ReelRenderer;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    public class ReelsFinder {

    private var reels:Array;

    public function ReelsFinder(target:DisplayObjectContainer) {

        reels = [];
        var tot:int = target.numChildren;

        for(var i:int = 0; i < tot; i++){

            var item:DisplayObject = target.getChildAt(i);

            if(item is ReelRenderer){

                reels.push(item);

            }

        }

    }

    public function get total():int{

        return reels.length;

    }

    public function getReel(index:int):ReelRenderer{

        return reels[index] as ReelRenderer;

    }
}
}

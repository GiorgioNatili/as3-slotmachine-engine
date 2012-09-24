/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/5/12
 * Time: 11:20 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.gui {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;

public class Square extends Sprite{

    public function Square() {

        addEventListener(Event.ADDED_TO_STAGE, onAdded);

    }

    private function onAdded(event:Event):void {

        event.target.removeEventListener(event.type, arguments.callee);

        var g:Graphics = graphics;

        g.beginFill(0xffffff * Math.random());
        g.drawRect(0, 0, 100 * Math.random(), 120 * Math.random());
        g.endFill();

    }
}
}

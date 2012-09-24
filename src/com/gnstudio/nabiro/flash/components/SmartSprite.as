/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 11:42 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gnstudio.nabiro.flash.components {
import flash.display.Sprite;
import flash.events.Event;

public class SmartSprite extends Sprite{

    public function SmartSprite() {

        addEventListener(Event.FRAME_CONSTRUCTED, onFrameConstructed);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage)

    }

    private function onFrameConstructed(e:Event):void{

        e.target.removeEventListener(e.type, arguments.callee);

        initView();

    }

    protected function init():void{



    }

    private function onAddedToStage(e:Event):void{

        e.target.removeEventListener(e.type, arguments.callee);

        init();

    }

    protected function initView():void{



    }

    private function onRemovedFromStage(e:Event):void{

        e.target.removeEventListener(e.type, arguments.callee);

        dispose();

    }

    protected function dispose():void{


    }
}
}

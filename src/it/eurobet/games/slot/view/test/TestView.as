/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 11:31 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.test {
import com.gnstudio.nabiro.flash.components.ButtonState;
import com.gnstudio.nabiro.flash.components.SmartSprite;
import com.gnstudio.nabiro.mvp.core.IView;
import com.gnstudio.nabiro.mvp.mapper.IMapperCandidate;

import flash.display.Graphics;

import flash.display.SimpleButton;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


public class TestView extends SmartSprite implements IMapperCandidate, IView{


    private var testButton:SimpleButton;
    private var presenter:Test;

    public function TestView() {



    }

    override protected function init():void{

        presenter = new Test(this);

    }

    override protected function initView():void{

        testButton = new SimpleButton();

        testButton.downState = testButton.overState = testButton.hitTestState = new ButtonState(0xff0000, 100, 22);
        testButton.upState = new ButtonState(0x00ff00, 100, 22);

        testButton.addEventListener(MouseEvent.CLICK, onTestClick);

        addChild(testButton);

    }

    private  function onTestClick(e:MouseEvent):void{

        presenter.notify();

    }


}
}

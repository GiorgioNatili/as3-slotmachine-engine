/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/5/12
 * Time: 11:26 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.remover {
import com.gnstudio.nabiro.flash.components.ButtonState;
import com.gnstudio.nabiro.mvp.command.CommandCallEvent;
import com.gnstudio.nabiro.mvp.command.CommandQueue;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

import it.eurobet.games.slot.commands.HideItems;
import it.eurobet.games.slot.view.gui.Square;

public class Remover extends Sprite{

    public function Remover() {

        var testButton:SimpleButton = new SimpleButton();

        testButton.downState = testButton.overState = testButton.hitTestState = new ButtonState(0x66666, 100, 22);
        testButton.upState = new ButtonState(0x242424, 100, 22);

        testButton.addEventListener(MouseEvent.CLICK, onTestClick);

        addChild(testButton);

    }

    private function onTestClick(event:MouseEvent):void {

        var actions:CommandQueue = new CommandQueue(false);

        if ( parent != null ) {

            actions.addCommand(new HideItems(Square, parent, false));

        }

        dispatchEvent(new CommandCallEvent(CommandCallEvent.COMMAND, actions));

    }
}
}

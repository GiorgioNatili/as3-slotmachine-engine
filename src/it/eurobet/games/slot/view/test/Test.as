/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 11:32 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.test {
import com.gnstudio.nabiro.mvp.core.IView;
import com.gnstudio.nabiro.mvp.core.Presenter;

import it.eurobet.games.slot.events.SlotInstructionEvent;

public class Test extends Presenter{

    public function Test(v:IView) {

        super (v);

    }

    public function notify():void{

        _view.dispatchEvent(new SlotInstructionEvent('HelloWorld',  Math.random()));

    }

}
}

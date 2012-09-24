/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:31 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.receiver {
import com.gnstudio.nabiro.mvp.core.IView;
import com.gnstudio.nabiro.mvp.core.Presenter;

import it.eurobet.games.slot.instructions.HelloWorld;

internal class Receiver extends Presenter{

    public function Receiver(v:IView) {

        super(v);

        view.addEventListener(HelloWorld.DO_HANDLE, onHelloWorld)

    }

    private function onHelloWorld(instruction:HelloWorld):void{

        view.showMessage("hello world " + instruction.parameters);

    }

    private function get view():IShowData{

        return _view as IShowData;

    }

}
}

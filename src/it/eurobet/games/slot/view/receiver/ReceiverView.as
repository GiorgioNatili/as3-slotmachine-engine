/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:27 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.receiver {
import com.gnstudio.nabiro.flash.components.SmartSprite;
import com.gnstudio.nabiro.mvp.mapper.IMapperCandidate;

import flash.text.TextField;
import flash.text.TextFieldType;

public class ReceiverView extends SmartSprite implements IShowData{

    private var label:TextField;
    private var presenter:Receiver;

    public function ReceiverView() {

        presenter = new Receiver(this);

    }


    override protected function init():void {

        super.init();

        label = new TextField();

        label.type = TextFieldType.DYNAMIC;
        label.width = 120;
        label.height = 22;

    }

    override protected function initView():void {

        super.initView();

        addChild(label);

    }

    public function showMessage(value:String):void {

        label.text = value;

    }
}
}

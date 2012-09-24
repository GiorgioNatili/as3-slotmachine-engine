/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/5/12
 * Time: 11:02 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.commands {

    import com.gnstudio.nabiro.mvp.command.AbstractCommand;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    public class HideItems extends AbstractCommand{

    private var itemClass:Class;
    private var toShow:Boolean;
    private var currentTarget:DisplayObjectContainer;

    public function HideItems(clazz:Class, target:DisplayObjectContainer, visible:Boolean = false) {

        super();

        itemClass = clazz;
        toShow = visible;
        currentTarget = target;

    }

    override public function execute():void {

       for(var i:int = 0; i < currentTarget.numChildren; i++){

           var item:DisplayObject = currentTarget.getChildAt(i);

           if(item is itemClass){

               item.visible = toShow;

           }

       }


    }

    override protected function onCommandComplete(params:* = null):void {

        super.onCommandComplete(params);

    }

    override protected function onCommandFail(errorMessage:String = null):void {

        super.onCommandFail(errorMessage);

    }
}
}

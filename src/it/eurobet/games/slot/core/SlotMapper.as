/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 11:23 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.core {

    import flash.events.EventDispatcher;

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Mapper;
    import it.eurobet.events.InstructionEvent;
    import it.eurobet.games.slot.instructions.AnimateReels;
    import it.eurobet.games.slot.instructions.AnimateRenderData;
    import it.eurobet.games.slot.instructions.AnimateSymbol;
    import it.eurobet.games.slot.instructions.HelloWorld;
    import it.eurobet.games.slot.instructions.InitSlot;
    import it.eurobet.games.slot.instructions.InitTransitions;
    import it.eurobet.games.slot.instructions.ShareSlotAssets;
    import it.eurobet.games.slot.instructions.SpinReels;
    import it.eurobet.games.slot.instructions.TexturesReadyToBuild;
    import it.eurobet.games.slot.instructions.UpdateReels;
    import it.eurobet.ui.ModalWindow;

public class SlotMapper extends Mapper{

    private var helloWorld:HelloWorld;
    private var initSlot:InitSlot;
    private var shareSlotAssets:ShareSlotAssets;
    private var initTransitions:InitTransitions;
    private var texturesReadyToBuild:TexturesReadyToBuild;
    private var spinReels:SpinReels;
    private var updateReels:UpdateReels;
    private var animateReels:AnimateReels;
    private var animateSymbol:AnimateSymbol;
    private var animateRender:AnimateRenderData;

    public function SlotMapper(tg:EventDispatcher = null) {

        super(tg);

    }

    override protected function onInstruction(e:*):void {

        // trace('overridden onInstruction', e);

        if(e.isPreventable && e.currentTarget is ModalWindow){

            e.stopImmediatePropagation();

        }else{

            super.onInstruction(e);

        }

    }

    /*
    override protected function onCommand(e:CommandCallEvent):void {

        super.onCommand(e);

    }
     */
}
}

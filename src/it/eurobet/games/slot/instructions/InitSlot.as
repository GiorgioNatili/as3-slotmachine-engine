/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:19 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {

    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.Instruction;
    import it.eurobet.games.slot.model.entities.Reel;
    import it.eurobet.games.slot.model.entities.WinningLine;
    import it.eurobet.games.slot.model.vos.GridInfo;
    import it.eurobet.games.slot.services.SlotDataProvider;

    import starling.events.Event;

    public class InitSlot extends Instruction{

    /**
     * @private
     * Define the event type.
     *
     * <p>Use DO_HANDLE constant to listen for the instruction.</p>
     */
    public static const DO_HANDLE:String = "onInitSlot";

    /**
     * @param o IEventDispatcher
     * @param params None.
     * @param bubbles Boolean
     * @param cancelable Boolean
     */
    public function InitSlot(o:*, params:* = null, bubbles:Boolean = false) {

        super(o, DO_HANDLE, params, bubbles);

    }

    public function get winningLines():Vector.<WinningLine>{

        return parameters.winningLines;

    }

    public function get reels():Vector.<Reel>{

        return parameters.reels;

    }

    public function get grid():GridInfo{

        return parameters.grid;

    }

    // TODO remove for production
    public function getReelSequenceByIndex(index:int):String{

       return ((parameters as SlotDataProvider).reels[index] as Reel).sequence;

    }

    /**
     * @private
     */
    override public function clone():Event {

        return new InitSlot(origin, parameters);

    }
}
}

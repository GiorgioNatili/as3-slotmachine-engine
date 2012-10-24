/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:14 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.events {

    import com.gnstudio.nabiro.mvp.instructions.InstructionEvent;

    import flash.events.Event;


    public class SlotInstructionEvent extends InstructionEvent{

    public static var DEFAULT:String = "";

    public function SlotInstructionEvent(instruction:String, params:*=null, preventable:Boolean=false, bubbles:Boolean=true){

        // This has to match the root package of the instructions, to add
        // additional sub-packaging add static properties to the class and use
        // them to compose the name
        base = "it.eurobet.games.slot.instructions.";

        super(base + instruction, params, preventable, bubbles);

        // trace("Instruction initialized", toPerform);

    }

    override public function clone():Event {

        return new SlotInstructionEvent(toPerform, parameters, isPreventable);

    }

}
}

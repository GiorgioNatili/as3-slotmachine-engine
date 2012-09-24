/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:19 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.instructions {
import com.gnstudio.nabiro.mvp.instructions.Instruction;

import flash.events.Event;

import flash.events.IEventDispatcher;

public class HelloWorld extends Instruction{

    /**
     * @private
     * Define the event type.
     *
     * <p>Use DO_HANDLE constant to listen for the instruction.</p>
     */
    public static const DO_HANDLE:String = "onHelloWorld";

    /**
     * @param o IEventDispatcher
     * @param params None.
     * @param bubbles Boolean
     * @param cancelable Boolean
     */
    public function HelloWorld(o:*, params:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {

        super(o, DO_HANDLE, params, bubbles, cancelable);

    }

    /**
     * @private
     */
    override public function clone():Event {

        return new HelloWorld(origin, parameters);

    }
}
}

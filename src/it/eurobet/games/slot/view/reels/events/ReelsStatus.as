/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/14/12
 * Time: 2:17 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels.events {

    import starling.events.Event;

    public class ReelsStatus extends Event{

    public static const REELS_READY:String = 'onReelsReady';

    public function ReelsStatus(type:String, bubbles:Boolean = false) {

        super (type, bubbles);

    }

}
}

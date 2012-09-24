/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/19/12
 * Time: 4:23 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.slot {

    import it.eurobet.core.IStarlingView;
    import it.eurobet.core.IWillBeObserved;

    import starling.display.Image;

    public interface ISlotView extends IStarlingView, IWillBeObserved{

        function get background():Image;

    }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:33 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels {

    import flash.geom.Point;

    import it.eurobet.core.IStarlingView;
    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.games.slot.model.vos.SpinReelData;

    public interface IReelsView extends IStarlingView, IWillBeObserved{

    function addReel(value:Vector.<String>, position:Point, gridHeight:Number):void;
    function updateReelValue(id:int, value:Vector.<String>):void;
    function spinReel(id:int, value:SpinReelData):void

}
}

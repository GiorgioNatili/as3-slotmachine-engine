/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:26 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.receiver {
import com.gnstudio.nabiro.mvp.core.IView;
import com.gnstudio.nabiro.mvp.mapper.IMapperCandidate;

public interface IShowData extends IView, IMapperCandidate{

    function showMessage(value:String):void;

}
}

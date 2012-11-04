/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/6/12
 * Time: 2:04 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.core {
import flash.events.IEventDispatcher;

import it.eurobet.games.slot.model.vos.GridInfo;

public interface IConfigApp extends IEventDispatcher{

    function get multistage():Boolean;
    function get type():String;
    function get assetsFile():String;
    function get assetsPath():String;
    function get transitions():XMLList;
    function get symbolsTexture():String;
    function get symbolsTextureInfo():String;
    function get winningLinesTexture():String;
    function get winningLinesTextureInfo():String;
    function get background():String;
}
}

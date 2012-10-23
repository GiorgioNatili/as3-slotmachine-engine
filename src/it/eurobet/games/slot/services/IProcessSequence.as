/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {

public interface IProcessSequence {

    function getSymbols(raw:Array, max:int = int.MAX_VALUE):Vector.<String>;
    function getWinningSequence(raw:Array, index:int, tot:int):Vector.<String>;
    function getWinningSymbols(raw:Array, index:int, tot:int):Vector.<String>;
    function getMovingSequence(raw:Array, tot:int):Vector.<String>;


}
}

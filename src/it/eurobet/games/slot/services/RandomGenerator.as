/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/19/12
 * Time: 12:13 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {

public class RandomGenerator {

    private var _number:int;

    public function RandomGenerator(tot:int) {

        _number = tot;

    }

    public function get random():int{

        var rnd:Number = Math.random();

        return int(rnd * _number);

    }
}
}

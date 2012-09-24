/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/20/12
 * Time: 12:17 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels.helpers {

    public class OrderProvider {

        private var indexes:Array;
        private var limit:int;

        public function OrderProvider(tot:int) {

            limit = tot;

        }

        public function build():Array{

            indexes = [];
            var tmp:Array = [];

            for(var i:int = 0; i < limit; i++){

                tmp.push(i);

            }

            indexes = tmp;

            return indexes;

        }

        public function buildRandom():Array{

            indexes = [];
            var tmp:Array = [];

            for(var i:int = 0; i < limit; i++){

                tmp.push(i);

            }

            while (tmp.length > 0) {

                indexes.push(tmp.splice(Math.round(Math.random() * (tmp.length - 1)), 1)[0]);

            }

            return indexes;

        }

        private function rand(min:Number, max:Number):Number {

            return(Math.floor(Math.random()*(max - min + 1)) + min);

        }
    }
}
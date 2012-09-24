/**
 * Location:    it.eurobet.utils
 * User:        giorgionatili
 * Date:        9/19/12
 * Time:        5:27 PM
 * Github:      https://github.com/GiorgioNatili
 */
package it.eurobet.utils {

    public class VectorRandomizer {

        private var data:Vector.<*>;

        public function VectorRandomizer(vector:Vector.<*>) {

            data = vector;

        }


        public function get randomStrings():Vector.<String>{

            var local:Vector.<String> = new Vector.<String>(data.length);

            while(data.length > 0){

                var index:int = int(Math.random() * data.length);
                var element = data.splice(index, 1);


                local.push(element[0]);

            }

            return local;

        }

    }
}

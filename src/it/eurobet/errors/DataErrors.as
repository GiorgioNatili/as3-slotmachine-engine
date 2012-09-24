/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/13/12
 * Time: 7:33 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.errors {

    public class DataErrors extends Error{

        public function DataErrors(message:String, errorID:int) {

            super(message, errorID);

        }
    }
}

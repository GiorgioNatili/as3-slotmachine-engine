/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/19/12
 * Time: 1:26 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.errors {

    public class ResourceErrors extends Error{

        public function ResourceErrors(message:String, errorID:int) {

            super(message, errorID);

        }
    }
}

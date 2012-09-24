/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/13/12
 * Time: 7:37 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.errors {

    public class TextureErrors extends Error{

        public function TextureErrors(message:String, errorID:int) {

            super(message, errorID);

        }
    }
}

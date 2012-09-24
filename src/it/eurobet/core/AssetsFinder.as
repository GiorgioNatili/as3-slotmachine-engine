/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/12/12
 * Time: 8:07 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import flash.display.Loader;
    import flash.events.Event;
    import flash.media.Sound;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    /**
     * The <code>AssetsFinder</code> class is used by the
     * <code>Assets</code> class to dynamically load
     * assets in an AS3 project. The class is made to work
     * with Starling.
     */

    public class AssetsFinder{
        /**
         * Main root directory; equivalent to <code>Asset</code>'s
         * <code>defaultDirectory</code>.
         * 0
         * @private
         * */
        private var dir:String;
        /**
         * The file's location.
         *
         * @private
         * */
        private var file:String;
        /**
         * The file's extension.
         *
         * @private
         * */
        private var ext:String;
        /**
         * The funciton to call when the load completes.
         *
         * @private
         * */
        private var callback:Function;
        /**
         * The data retrieved from the load.
         *
         * @private
         * */
        private var data:*;

        /**
         * Creates and starts a new AssetLoader.
         *
         * @param dir The root directory of the file
         * @param file The location of the file in dir
         * @param ext The file's extension
         * @param callback The function to call when the load completes
         * */
        public function AssetsFinder(dir:String, file:String, ext:String, callback:Function){

            this.dir = dir;
            this.file = file;
            this.ext = ext;
            this.callback = callback;

            switch(ext){

                case "png":
                case "jpg":
                    var loader:Loader = new Loader();
                    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoadComplete);
                    loader.load(new URLRequest(dir + file + "." + ext));
                    break;
                case "xml":
                case "txt":
                    var uloader:URLLoader = new URLLoader();
                    uloader.addEventListener(Event.COMPLETE, dataLoadComplete);
                    uloader.load(new URLRequest(dir + file + "." + ext));
                    break;
                case "mp3":
                case "wav":
                    var snd:Sound = new Sound();
                    snd.addEventListener(Event.COMPLETE, soundLoadComplete);
                    snd.load(new URLRequest(dir + file + "." + ext));
                    break;
            }
        }

        /**
         * Returns the file path.
         *
         * @return The file path.
         * */
        public function get path():String{

            return file + "." + ext;

        }

        /**
         * Returns the loaded content.
         *
         * @return The loaded content.
         * */
        public function get content():*{

            return data;

        }

        /**
         * Sets <code>data</code> according to the loaded
         * content and runs <code>callback</code>.
         *
         * @eventType flash.events.Event.COMPLETE
         * @return void
         * @private
         * */
        private function imgLoadComplete(event:Event):void{

            data = event.target.content;
            callback(this);

        }

        /**
         * Sets <code>data</code> according to the loaded
         * content and runs <code>callback</code>.
         *
         * @eventType flash.events.Event.COMPLETE
         * @return void
         * @private
         * */
        private function dataLoadComplete(event:Event):void{

            data = event.target.data;
            callback(this);

        }

        /**
         * Sets <code>data</code> according to the loaded
         * content and runs <code>callback</code>.
         *
         * @eventType flash.events.Event.COMPLETE
         * @return void
         * @private
         * */
        private function soundLoadComplete(event:Event):void{

            data = event.target;
            callback(this);

        }
    }
}

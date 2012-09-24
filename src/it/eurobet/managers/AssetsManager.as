/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/12/12
 * Time: 8:04 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.managers {

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.events.ProgressEvent;
    import flash.media.Sound;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    import it.eurobet.core.AssetsFinder;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * The <code>Assets</code> class is used to dynamically load
     * assets in an AS3 project. The class is made to work
     * with Starling.
     */

    public class AssetsManager implements IEventDispatcher{
        /**
         * The default directory for assets. Any file
         * path will be appended to this to find the full
         * path of the file.
         * */
        private var defaultDirectory:String = "";
        /**
         * The dictionary that holds all of the assets.
         *
         * @private
         * */
        private static var dict:Dictionary = new Dictionary();
        /**
         * The size of the dictionary.
         *
         * @private
         * */
        private static var dictSize:int = 0;
        /**
         * The number of assets that will be loaded
         * when all loading is complete.
         *
         * @private
         * */
        private static var loadCount:int = 0;
        /**
         * The <code>EventDispatcher</code> object used
         * by this class to dispatch <code>ProgressEvent.PROGRESS</code>
         * and <code>Event.COMPLETE</coded>.
         *
         * @private
         * */

        private var eventDispatcher:EventDispatcher;

        public function AssetsManager(dir:String){

            eventDispatcher = new EventDispatcher(this);

            defaultDirectory = dir;
        }

        /**
         * Loads all assets from the XML file at path.
         *
         * @param path Location of the XML file
         * @return void
         * */
        public function loadAssets(path:String):void{

            var urll:URLLoader = new URLLoader();
            urll.addEventListener(Event.COMPLETE, startLoad);
            urll.load(new URLRequest(defaultDirectory + path));

        }

        /**
         * Creates an <code>XML</code> object from the
         * loaded data, updates <code>loadCount</code>,
         * and starts the process of loading the files.
         *
         * @eventType flash.events.Event.COMPLETE
         * @return void
         * @private
         * */
        private function startLoad(event:Event):void{

            var xml:XML = new XML(event.target.data);
            loadCount += count(xml);
            loadAll(xml, "");

        }

        /**
         * Counts how many assets will be loaded from
         * the XML file.
         *
         * @param xml The XML file to be loaded
         * @return A count of how many assets will be loaded
         * @private
         * */
        private static function count(xml:XML):int{

            var ret:int = xml.asset.length();

            for each(var x:XML in xml.directory){

                ret += count(x);

            }

            return ret;
        }

        /**
         * Instantiates and configures <code>AssetLoader</code>
         * instances to load the files.
         *
         * @param xml The XML file to be loaded
         * @param dir The current root directory
         * @return void
         * @private
         * */
        private function loadAll(xml:XML, dir:String):void{

            for each(var x:XML in xml.asset){

                var finder:AssetsFinder = new AssetsFinder(defaultDirectory, dir + x.text(), x.@ext, loadComplete);

            }

            for each(x in xml.directory){

                loadAll(x, dir + x.@name + "/");

            }
        }

        /**
         * Moves the data from a completed <code>AssetLoader</code> to
         * the dictionary. Also dispatches the appropriate events.
         *
         * @param loader The completed <code>AssetLoader</code>
         * @return void
         * @private
         * */
        private function loadComplete(loader:AssetsFinder):void{

            dict[loader.path] = loader.content;
            dictSize++;
            dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, dictSize, loadCount));

            if(dictSize == loadCount){

                dispatchEvent(new Event(Event.COMPLETE));

            }
        }

        /**
         * Returns the asset at the given location.
         *
         * @param path The location from which to retreive
         * the asset
         * @return The requested asset
         * */
        public function getAsset(path:String):*{

            return dict[path];

        }

        /**
         * Returns an <code>Image</code> made from the
         * asset at the given location.
         *
         * @param path The location from which to retreive
         * the <code>Image</code>
         * @return The requested <code>Image</code>
         * @see starling.display.Image
         * */
        public function getImage(path:String):Image{

            return new Image(getTexture(path));

        }

        /**
         * Returns a <code>Texture</code> made from the
         * asset at the given location.
         *
         * @param path The location from which to retreive
         * the <code>Texture</code>
         * @return The requested <code>Texture</code>
         * @see starling.display.Texture
         * */
        public function getTexture(path:String):Texture{

            if(!(getAsset(path) is Texture)){

                dict[path] = Texture.fromBitmap(getAsset(path));

            }

            return getAsset(path);

        }

        /**
         * Returns an <code>XML</code> instance made from the
         * asset at the given location.
         *
         * @param path The location from which to retreive
         * the <code>XML</code>
         * @return The requested XML
         * */
        public function getXML(path:String):XML{

            return new XML(getAsset(path));

        }

        /**
         * Returns a <code>MovieClip</code> instance made from the
         * asset at the given location.
         *
         * @param path The location from which to retreive
         * the <code>MovieClip</code>
         * @return The requested <code>MovieClip</code>
         * @see starling.display.MovieClip
         * */
        public function getAnimation(path:String):MovieClip{

            var t:Texture = getImage(path + ".png").texture;
            var x:XML = getXML(path + ".xml");
            var ta:TextureAtlas = new TextureAtlas(t, x);
            var mc:MovieClip = new MovieClip(ta.getTextures(), 60);

            return mc;

        }

        /**
         * Returns a <code>String</code> with the String contained
         * in the associated .txt file.
         *
         * @param path The location from which to retreive
         * the text data
         * @return The value in the file
         * */
        public function getText(path:String):String{

            return getAsset(path);

        }

        /**
         * Returns a <code>Sound</code> instance made from the sound
         * in the associated .wav or .mp3 file.
         *
         * @param path The location from which to retreive
         * the sound data
         * @return The sound
         * */
        public function getSound(path:String):Sound{

            return getAsset(path);

        }

        /************************************
         * IEventDispatcher immplementation
         *************************************/
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void{

            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);

        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void	{

            eventDispatcher.removeEventListener(type, listener, useCapture);

        }

        public function dispatchEvent(event:Event):Boolean {

            return eventDispatcher.dispatchEvent(event);
        }

        public function hasEventListener(type:String):Boolean {

            return eventDispatcher.hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean {

            return eventDispatcher.willTrigger(type);

        }
    }
}



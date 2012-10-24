/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/12/12
 * Time: 9:00 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import it.eurobet.errors.TextureErrors;
    import it.eurobet.events.TexturesLoadEvent;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class TexturesLoader implements IEventDispatcher{

        private var eventDispatcher:EventDispatcher;

        private var xmlULR:URLRequest;
        private var imageULR:URLRequest;

        private var sourceData:Bitmap;
        private var sourceInfo:XML;
        private var _texturesAtlas:TextureAtlas;
        private var _textures:Texture;

        private var textureNames:Dictionary;
        private var _texturesReady:Boolean;
        private var _availableTextures:int;

        public function TexturesLoader(info:String, source:String) {

            eventDispatcher = new EventDispatcher(this);

            textureNames = new Dictionary(true);
            _availableTextures = 0;

            xmlULR = new URLRequest(info);
            imageULR = new URLRequest(source);

        }

        public function init():void{

            var loader:URLLoader = new URLLoader();

            loader.addEventListener(Event.COMPLETE, onInfoLoaded);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onInfoError)        ;

            loader.load(xmlULR);
        }

        private function onInfoError(event:IOErrorEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);
            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.INFO_LOADING_ERROR));

        }

        private function onInfoLoaded(event:Event):void {

            event.target.removeEventListener(event.type, arguments.callee);

            sourceInfo = XML(event.target.data);

            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.INFO_LOADED));
            loadSource();

        }

        private function loadSource():void {

            var loader:Loader = new Loader();

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSourceLoaded);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onSourceError);

            loader.load(imageULR);

        }

        private function onSourceError(event:IOErrorEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);

            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.SOURCE_LOADING_ERROR));

        }

        private function onSourceLoaded(event:Event):void {

            event.target.removeEventListener(event.type, arguments.callee);

            sourceData = Bitmap(event.target.content);
          //  textures = Texture.fromBitmap(sourceData);

            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.SOURCE_LOADED));
            prepareTexturesData();

        }

        private function prepareTexturesData():void {

            for each(var item:XML in sourceInfo.SubTexture.@name){

                textureNames[item.toXMLString()] = null;

            }

            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.TEXTURES_DATA_READY));

        }

        public function buildTextures():void{

            _textures = Texture.fromBitmap(sourceData);
            _texturesAtlas = new TextureAtlas(_textures, sourceInfo);

            for (var item:String in textureNames){

                textureNames[item] = _texturesAtlas.getTexture(item);
                _availableTextures++;

            }

            _texturesReady = true;
            dispatchEvent(new TexturesLoadEvent(TexturesLoadEvent.TEXTURES_READY));

        }

       public function getTextureByName(name:String):Texture{

           var texture:Texture;

           if(!textureNames[name]){

               // TODO Bring it back to error and remove the trace
               // throw new TextureErrors('The requested texture is not available, the method will return a random one.', 50);

               trace('\n\t', 'The requested texture "' + name + '" is not available, the method will return a random one.', '\n');

               var random:int = int(_availableTextures * Math.random());
               var items:XMLList = sourceInfo.SubTexture.@name;
               var itemName:String = items[random];
               texture = textureNames[itemName];

           }else{

               texture = textureNames[name];

           }

           return texture;

       }

        public function get textures():Texture {

            return _textures;

        }

        public function get texturesAtlas():TextureAtlas {

            return _texturesAtlas;

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

        public function get texturesReady():Boolean {

            return _texturesReady;

        }
    }
}

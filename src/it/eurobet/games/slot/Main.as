/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 11:30 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot {

    import com.gnstudio.nabiro.utilities.pico.PicoContainer;
    import com.gnstudio.nabiro.utilities.pico.PicoManager;

    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    import it.eurobet.core.AssetsBuilder;
    import it.eurobet.core.AssetsLoader;
    import it.eurobet.core.IEventDispatcher;
    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.core.MapperManager;
    import it.eurobet.core.TexturesLoader;
    import it.eurobet.errors.DataErrors;
    import it.eurobet.errors.ResourceErrors;
    import it.eurobet.errors.TextureErrors;
    import it.eurobet.events.CommandCallEvent;
    import it.eurobet.events.TexturesLoadEvent;
    import it.eurobet.games.slot.core.AppConfig;
    import it.eurobet.games.slot.core.SlotMapper;
    import it.eurobet.games.slot.core.IConfigApp;
    import it.eurobet.games.slot.events.AssetsEvent;
    import it.eurobet.games.slot.events.DataEvent;
    import it.eurobet.games.slot.events.SlotInstructionEvent;
    import it.eurobet.games.slot.services.DataReader;
    import it.eurobet.games.slot.services.SlotDataProvider;
    import it.eurobet.games.slot.services.TransitionProvider;
    import it.eurobet.games.slot.view.gui.Square;
    import it.eurobet.games.slot.view.receiver.ReceiverView;
    import it.eurobet.games.slot.view.remover.Remover;
    import it.eurobet.games.slot.view.slot.SlotView;
    import it.eurobet.games.slot.view.test.TestView;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Stage;
    import starling.events.EventDispatcher;

    public class Main extends Sprite {

        private const CONFIG:String = 'data/slotconfig.xml';
        private const DATA_SOURCE:String = 'data/slotdata.xml';

        private var _mapper:SlotMapper;
        private var _mapperManager:MapperManager;
        private var appConfig:IConfigApp;
        private var dataReader:DataReader;
        private var builder:AssetsBuilder;
        private var mapping:Dictionary;
        private var slot:Starling;
        private var container:Sprite;

        // private var reelsView:ReelsView;

        public function Main() {

            mapping = new Dictionary(true);

            mapping['A'] = 'Compass';
            mapping['B'] = 'Skul';
            mapping['C'] = 'SpyGlass';
            mapping['D'] = 'Anchor';
            mapping['E'] = 'Helm';
            mapping['F'] = 'Gun';
            mapping['G'] = 'Chest';
            mapping['H'] = 'Map';

            var sharedData:PicoContainer = new PicoContainer();
            PicoManager.addContainer(sharedData, "sharedData");

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            init();

        }

        private function init():void {

            createGame();
            prepareInstructionMapper();
            configApp();

            stage.addEventListener(Event.RESIZE, handleBackground);

            var limit:int = Math.random() * 20;

            for (var i:int = 0; i < limit; i++) {

                var item:Square = new Square();

                item.name = "square" + i;
                item.x = 100 + (Math.random() * stage.width);
                item.y = 100 + (Math.random() * stage.height);

                // addChild(item);

            }

        }

        private function configApp():void {

            appConfig = new AppConfig(CONFIG) as IConfigApp;
            appConfig.addEventListener(DataEvent.CONFIG_READY, onConfigReady);
            appConfig.addEventListener(DataEvent.CONFIG_FAULT, onConfigFault);

        }

        private function loadData():void {

            dataReader = new DataReader(DATA_SOURCE);
            dataReader.addEventListener(DataEvent.DATA_READY, onDataReady);
            dataReader.addEventListener(DataEvent.DATA_FAULT, onDataFault);

        }

        private function onDataReady(event:DataEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);

            // reels
            // winning lise
            // grid info

            var assets:AssetsLoader = new AssetsLoader(appConfig.assetsPath + appConfig.assetsFile);

            assets.addEventListener(AssetsEvent.ASSETS_READY, onAssetsReady);
            assets.addEventListener(AssetsEvent.ASSETS_FAULT, onAssetsFault);

        }

        private function onAssetsReady(event:AssetsEvent):void {

            builder = new AssetsBuilder(event.target.assets, mapping);

           /*
            var builder:AssetsBuilder = new AssetsBuilder(event.target.assets, mapping);
            dispatchEvent(new SlotInstructionEvent('ShareSlotAssets', builder));

            var value:SlotDataProvider = new SlotDataProvider(dataReader);
            dispatchEvent(new SlotInstructionEvent('InitSlot', value));

            var transitions:TransitionProvider = new TransitionProvider(appConfig.transitions);
            dispatchEvent(new SlotInstructionEvent('InitTransitions', transitions));

            */

            var textures:TexturesLoader = new TexturesLoader(appConfig.assetsPath + appConfig.symbolsTextureInfo, appConfig.assetsPath + appConfig.symbolsTexture);

            textures.addEventListener(TexturesLoadEvent.TEXTURES_DATA_READY, onTexturesReady);
            textures.addEventListener(TexturesLoadEvent.SOURCE_LOADING_ERROR, onTexturesSourceError);
            textures.addEventListener(TexturesLoadEvent.INFO_LOADING_ERROR, onTexturesInfoError);

            textures.init();

        }

        private function onConfigReady(e:Event):void {

            e.target.removeEventListener(e.type, arguments.callee);

            loadMainBackground(appConfig.assetsPath + appConfig.background);

        }

        private function loadMainBackground(path:String):void {

            var url:URLRequest = new URLRequest(path);

            var loader:Loader = new Loader();

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBackgroundReady);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onBackgroundFault);

            loader.load(url);

        }

        private function onBackgroundReady(event:Event):void {

            event.target.removeEventListener(event.type, arguments.callee);

            if(container){

                removeChild(container);
                container = null;

            }

            container = new Sprite();

            container.addChild((event.target as LoaderInfo).content);
            addChild(container);

            loadData();

        }

        private function onBackgroundFault(event:IOErrorEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);

            throw new ResourceErrors('Unable to load the background file', 65);

        }

        private function onTexturesReady(event:TexturesLoadEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);

            // Assets that are not part of startling
            dispatchEvent(new SlotInstructionEvent('ShareSlotAssets', builder));

            // Assets that are used in starling
            dispatchEvent(new SlotInstructionEvent('TexturesReadyToBuild', event.target as TexturesLoader));

            // Data needed to build the slot
            var value:SlotDataProvider = new SlotDataProvider(dataReader);
            dispatchEvent(new SlotInstructionEvent('InitSlot', value));

            // Data needed to build the transition for each slot
            var transitions:TransitionProvider = new TransitionProvider(appConfig.transitions);
            dispatchEvent(new SlotInstructionEvent('InitTransitions', transitions));

        }

        private function createGame():void {

            slot = new Starling(SlotView, stage);
            slot.start();

            slot.showStats= true;

            slot.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);

        }

        private function onContextCreated(event:Event):void {

            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1) {

                Starling.current.nativeStage.frameRate = 30;

            }else{

                Starling.current.nativeStage.frameRate = 60;

            }

        }

        private function prepareInstructionMapper():void {

            trace("Prepare Mapper");

            _mapper = new SlotMapper(this);
            _mapper.addTarget(slot.stage);

            // Initialize the mapper manager, the starling objects that has to be handled via instructions
            var listeners:Vector.<DisplayObject> = new Vector.<DisplayObject>();
            listeners[0] = slot.stage;

            _mapperManager = new MapperManager(listeners, _mapper);
            _mapperManager.initialize();

        }

        private function handleBackground(event:Event):void {

            if(container && container.numChildren){

                container.x = (stage.stageWidth - container.width) / 2;
                container.y = (stage.stageHeight - container.height) / 2;

            }

        }

        private function onTexturesInfoError(event:TexturesLoadEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);
            throw new TextureErrors('Unable to load the texture info (e.g. the XML)', 40);

        }

        private function onTexturesSourceError(event:TexturesLoadEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);
            throw new TextureErrors('Unable to load the texture source (i.e. the PNG)', 30);

        }

        private function onDataFault(event:DataEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);
            throw new DataErrors('Unable to load game initialization data', 20);

        }

        private function onConfigFault(event:DataEvent):void {

            event.target.removeEventListener(event.type, arguments.callee);
            throw new DataErrors('Unable to load config data', 10);

        }

        private function onAssetsFault(event:Event):void {

            event.target.removeEventListener(event.type, arguments.callee);
            throw new DataErrors('Unable to load the assets file', 15);

        }

    }
}

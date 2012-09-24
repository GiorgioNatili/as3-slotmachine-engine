/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/13/12
 * Time: 11:48 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.slot {

    import it.eurobet.components.TextureButton;
    import it.eurobet.events.MouseEvent;

    import starling.textures.Texture;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.utils.Timer;

    import it.eurobet.events.CommandCallEvent;
    import it.eurobet.games.slot.core.EmbeddedAssets;
    import it.eurobet.games.slot.view.reels.ReelsView;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.ResizeEvent;
    import starling.textures.TextureAtlas;

    public class SlotView extends Sprite implements ISlotView{

        private var reels:ReelsView;
        private var _background:Image;

        private var swapSymbols:TextureButton;
        private var spinSymbols:TextureButton;

        private var presenter:Slot;

        public function SlotView() {

            addEventListener(Event.ADDED_TO_STAGE, init);

            presenter = new Slot(this);
            reels = new ReelsView();

            trace('initialized')

        }

        private function init(e:Event):void{

            e.target.removeEventListener(e.type, arguments.callee);

            addChild(reels);
            createBackground();
            initButtons();

            stage.addEventListener(ResizeEvent.RESIZE, onResize);

        }

        private function initButtons():void{

            var texture:TextureAtlas = new TextureAtlas(Texture.fromBitmap( new EmbeddedAssets.BUTTONS_TEXTURE() ), XML(new EmbeddedAssets.BUTTONS_DATA()));

            swapSymbols = new TextureButton(texture, 'mc_swap', 'mc_swap_hover', 'mc_swap_hit', 'mc_swap_hit');

            swapSymbols.x = 50;
            swapSymbols.y = stage.stageHeight / 2;
            swapSymbols.useHandCursor = true;

            addChild(swapSymbols);

            swapSymbols.addEventListener(MouseEvent.CLICK, onUpdateReels);

            // ================================================

            spinSymbols = new TextureButton(texture, 'mc_spin', 'mc_spin_hover', 'mc_spin_hit', 'mc_spin_hit');

            spinSymbols.useHandCursor = true;
            spinSymbols.x = 190;
            spinSymbols.y = stage.stageHeight / 2;

            addChild(spinSymbols);

            spinSymbols.addEventListener(MouseEvent.CLICK, onSpinItems);

        }

        private function onSpinItems(event:MouseEvent):void {

            presenter.spin();

        }

        private function onUpdateReels(event:MouseEvent):void {

            presenter.updateReels();

        }

        private function createBackground():void {

            _background = new Image(Texture.fromBitmap(new EmbeddedAssets.GAME_BACKGROUND()));

            var rect:Rectangle = Starling.current.viewPort;
            updateBackground(rect.width, rect.height);

            addChild(_background);

        }

        private function onResize(event:ResizeEvent):void{

            var rect:Rectangle = new Rectangle();

            rect.width = event.width;
            rect.height = event.height;

            try{

                // resize the viewport
                Starling.current.viewPort = rect;

            }catch(error:Error){

                delayedResize(rect);

            }

            // assign the new stage width and height
            stage.stageWidth = event.width;
            stage.stageHeight = event.height;

            updateBackground(event.width, event.height);

        }

        private function updateBackground(w:Number, h:Number):void {

            _background.width = w;
            _background.height = h;

        }

        private function delayedResize(rect:Rectangle):void{

            var timer:Timer = new Timer(100, 1);

            timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void{

                event.target.removeEventListener(event.type, arguments.callee);

                Starling.current.viewPort = rect;
                timer.stop();

            });

            timer.start();

        }

        public function get background():Image{

            return _background;

        }
    }
}

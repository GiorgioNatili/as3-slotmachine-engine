/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/14/12
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels.components {

    import com.gnstudio.nabiro.flash.components.SmartStarlingSprite;

    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.text.TextFieldType;

    import it.eurobet.components.GuiWrapper;
    import it.eurobet.components.Symbol;
    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.games.slot.instructions.AnimateSymbol;

    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class ReelItem extends SmartStarlingSprite implements IWillBeObserved {

        private var label:TextField;
        private var _symbolID:String;
        private var symbolRender:Symbol;
        private var limit:Number;
        private var _speed:Number;
        private var _showID:Boolean;

        private const SYMBOL_TRANSITION_SPEED:Number = .3;

        public function ReelItem(data:String, renderer:Symbol) {

            _symbolID = data;
            symbolRender = renderer;
            _speed = 12;

            renderSymbol();

        }

        protected function renderSymbol():void {

            if(_showID){

                drawID();

            }

            addChild(symbolRender);

        }

        private function drawID():void {

            label = new TextField(22, 22, _symbolID);

            if (_symbolID) {

                addChild(label);

            }
        }

        override protected function init():void {

            super.init();

            addEventListener(AnimateSymbol.DO_HANDLE, onAnimateSymbol);


        }

        private function onAnimateSymbol(instruction:AnimateSymbol):void {

            removeEventListener(instruction.type, arguments.callee);

            limit = instruction.limit;

            if(instruction.reelID == (parent as ReelRenderer).id){

                var tween:* = new instruction.reelTransition.tweener(this, SYMBOL_TRANSITION_SPEED, {y: y + (limit - (y + height)), ease: instruction.reelTransition.easing, onComplete: onSymbolTweenCompleted});
                tween.play();

            }

        }

        private function onSymbolTweenCompleted():void {

            removeFromParent(true);

        }

        public function set speed(value:Number):void{

            _speed = value;

        }

        public function set showID(value:Boolean):void{

            _showID = value;

        }

        public function get symbolID():String {

            return _symbolID;

        }
    }
}

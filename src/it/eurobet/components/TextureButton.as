/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/15/12
 * Time: 9:50 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.components {

    import it.eurobet.events.MouseEvent;

    import flash.display.Stage;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.TextureAtlas;

   /* [Event(type="onStarlingPress",      name="it.eurobet.events.MouseEvent")]
    [Event(type="onStarlingRollOver",   name="it.eurobet.events.MouseEvent")]
    [Event(type="onStarlingClick",      name="it.eurobet.events.MouseEvent")]
    [Event(type="onStarlingRollout",    name="it.eurobet.events.MouseEvent")]*/

    public class TextureButton extends Sprite 
	{
        protected var _enable: Boolean = true;
        protected var _isPressed: Boolean;
        protected var _isRolledOver: Boolean;
		
        /**
         * Does we need to round coordinates to floor.
         */
        private var _useRoundCoordinates: Boolean = true;
		
        private var texture:TextureAtlas;
        private var onLabel:String;
        private var overLabel:String;
        private var hitLabel:String;
        private var clickLabel:String;
        private var overButton:Button;
        private var normalButton:Button;
        private var clickButton:Button;
        private var hitButton:Button;
		
        public function TextureButton(source:TextureAtlas, on:String, over:String, click:String, hit:String) 
		{
            texture = source;
            onLabel = on;
            overLabel = over;
            clickLabel = click;
            hitLabel = hit;
            addEventListener(TouchEvent.TOUCH, onTouchHandler);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }
		
        private function onAdded(event:Event):void 
		{
            event.target.removeEventListener(event.type, arguments.callee);
			
            normalButton = new Button(texture.getTexture(onLabel));
            addChild(normalButton);
			
            overButton = new Button(texture.getTexture(overLabel));
            overButton.visible = false;
            addChild(overButton);
			
            clickButton = new Button(texture.getTexture(clickLabel));
            clickButton.visible = false;
            addChild(clickButton);
			
            hitButton = new Button(texture.getTexture(hitLabel));
            hitButton.visible = false;
            addChild(hitButton);
        }
		
        // ------------------ PROPERTIES -------------------------------
		
        public function get enable(): Boolean {
            return _enable;
        }
		
        public function set enable(value: Boolean): void {
            _enable = value;
        }
		
        override public function set x(value: Number): void {
            super.x = _useRoundCoordinates ? int(value) : value;
        }
		
        override public function set y(value: Number): void {
            super.y = _useRoundCoordinates ? int(value) : value;
        }
		
        public function get useRoundCoordinates(): Boolean { 
			return _useRoundCoordinates; 
		}
		
        public function set useRoundCoordinates(value: Boolean): void {
            _useRoundCoordinates = value;
			
            if (value) {
                x = x;
                y = y;
            }
        }
		
        protected function onTouchHandler(event: TouchEvent): void 
		{
            var touch: Touch = event.getTouch(this);
            if (touch) {
                switch (touch.phase) {
                    case TouchPhase.HOVER:                                      // roll over
                    {
                        if (_isRolledOver) {
                            return;
                        }
						
                        _isRolledOver = true;
						
                        dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                        showOverState();
						
                        break;
                    }
					
                    case TouchPhase.BEGAN:                                      // press
                    {
                        if (_isPressed) {
                            return;
                        }
						
                        _isPressed = true;
						
                        dispatchEvent(new MouseEvent(MouseEvent.PRESS));
                        showPressState();
                        break;
                    }

                    case TouchPhase.ENDED:                                      // click
                    {
                        _isPressed = false;
						
                        isRolledOut();
                        dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        showClickState();
                        break;
                    }
					
                    default :
                    {
                    }
                }
            } else {
				
                _isRolledOver = false;
                dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
                showNormalState();
            }
        }
		
        protected function showOverState():void 
		{
            clickButton.visible = false;
            hitButton.visible = false;
            normalButton.visible = false;
            overButton.visible = true;
        }
		
        protected function showNormalState():void 
		{
            clickButton.visible = false;
            hitButton.visible = false;
            overButton.visible = false;
            normalButton.visible = true;
        }
		
        protected function showPressState():void 
		{
            clickButton.visible = false;
            normalButton.visible = false;
            overButton.visible = false;
            hitButton.visible = true;
        }
		
        protected function showClickState():void 
		{
            normalButton.visible = false;
            overButton.visible = false;
            hitButton.visible = false;
            clickButton.visible = true;
        }
		
        private function isRolledOut(): Boolean 
		{
            var value:Boolean;
            var stage: Stage = Starling.current.nativeStage;
            var mouseX: Number = stage.mouseX;
            var mouseY: Number = stage.mouseY;
            var bounds: Rectangle = getBounds(this);
            var point: Point = localToGlobal(new Point());
			
            if (mouseX > point.x && mouseX < point.x + bounds.width && mouseY > point.y && mouseY < point.y + bounds.height) {
                value = false;
            } 
			else {
                _isRolledOver = false;
                dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
                value = true;
            }
            return value;
        }
		
    }
}
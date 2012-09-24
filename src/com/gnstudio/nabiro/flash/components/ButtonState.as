/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 5/31/12
 * Time: 12:06 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gnstudio.nabiro.flash.components {
import flash.display.Shape;

public class ButtonState extends Shape{

    private var background:int;
    private var _width:int;
    private var _height:int;

    public function ButtonState(bgColor:uint, w:int, h:int) {

        background = bgColor;
        _width = w;
        _height = h;

        draw();
    }

    private function draw():void {

        graphics.beginFill(background);
        graphics.drawRect(0, 0, _width, _height);
        graphics.endFill();

    }

}
}

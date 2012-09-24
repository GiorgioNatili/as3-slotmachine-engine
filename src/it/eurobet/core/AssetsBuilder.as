/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/15/12
 * Time: 3:46 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.core {
import flash.display.Loader;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

import it.eurobet.components.GuiWrapper;

public class AssetsBuilder {

    private var currentData:Loader;
    private var mapping:Dictionary;

    public function AssetsBuilder(data:Loader, map:Dictionary) {

        currentData = data;
        mapping = map;

    }

    public function getSymbolDefinitionByName(name:String):Class{

        var nameToFind:String;

        if(!mapping[name]){

            nameToFind = 'Compass';

        }else{

            nameToFind = mapping[name];

        }

        return currentData.contentLoaderInfo.applicationDomain.getDefinition(nameToFind) as Class;

    }

    public function getItemByName(name:String):GuiWrapper{

        var Symbol:Class = getSymbolDefinitionByName(name);
        var temp:GuiWrapper = new Symbol();

        return temp;

    }
}
}

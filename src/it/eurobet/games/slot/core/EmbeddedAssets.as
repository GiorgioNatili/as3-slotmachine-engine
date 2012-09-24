/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/16/12
 * Time: 6:13 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.core {

    public class EmbeddedAssets {

        [Embed(source="/Users/giorgionatili/IdeaProjects/EurobetSlot/assets/slot/01/symbols/Buttons.xml", mimeType="application/octet-stream")]
        public static const BUTTONS_DATA:Class;

        [Embed(source="/Users/giorgionatili/IdeaProjects/EurobetSlot/assets/slot/01/symbols/Buttons.png")]
        public static const BUTTONS_TEXTURE:Class;

        [Embed(source="/Users/giorgionatili/IdeaProjects/EurobetSlot/assets/slot/01/miscellaneous/background.png")]
        public static const GAME_BACKGROUND:Class;

        [Embed(source="/Users/giorgionatili/IdeaProjects/EurobetSlot/assets/slot/01/symbols/bg_symbol.png")]
        public static const SYMBOL_BACKGROUND:Class;

    }
}

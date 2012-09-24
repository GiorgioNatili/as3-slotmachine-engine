/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 7/13/12
 * Time: 11:19 AM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.services {

    import it.eurobet.components.Symbol;
    import it.eurobet.components.Symbol;
    import it.eurobet.core.TexturesLoader;

    public class SymbolsProvider {

        private var texturesLoader:TexturesLoader;

        public function SymbolsProvider(textures:TexturesLoader) {

            texturesLoader = textures;

        }

        public function getSymbolByName(name:String):Symbol{

            if(!texturesLoader.texturesReady){

                texturesLoader.buildTextures();

            }

            return new Symbol(texturesLoader.getTextureByName(name));

        }
    }
}

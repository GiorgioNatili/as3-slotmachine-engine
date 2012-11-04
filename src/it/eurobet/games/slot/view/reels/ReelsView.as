/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:32 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels {

    import com.gnstudio.nabiro.flash.components.SmartStarlingSprite;

    import flash.geom.Point;

    import it.eurobet.components.TextureButton;
    import it.eurobet.core.CommandQueue;
    import it.eurobet.core.TexturesLoader;
    import it.eurobet.events.CommandCallEvent;
    import it.eurobet.games.slot.commands.HideStarlingItems;
    import it.eurobet.games.slot.instructions.TexturesReadyToBuild;
    import it.eurobet.games.slot.instructions.WinningTexturesReadyToBuild;
    import it.eurobet.games.slot.model.vos.SpinReelData;
    import it.eurobet.games.slot.view.reels.components.ReelItem;
    import it.eurobet.games.slot.view.reels.components.ReelRenderer;
    import it.eurobet.games.slot.view.reels.events.ReelsStatus;
    import it.eurobet.games.slot.view.reels.helpers.ReelsFinder;

    import starling.display.Quad;
    import starling.display.Sprite;

    public class ReelsView extends SmartStarlingSprite implements IReelsView{

    private var presenter:Reels;

    private var reelsFinder:ReelsFinder;
    private var textures:TexturesLoader;
    private var winningTextures:TexturesLoader;

    public function ReelsView() {

        presenter = new Reels(this);
        presenter.addEventListener(ReelsStatus.REELS_READY, onReelsReady);

        addEventListener(TexturesReadyToBuild.DO_HANDLE, onTexturesReadyToBuild);
        addEventListener(WinningTexturesReadyToBuild.DO_HANDLE, onWinningTexturesReadyToBuild);

    }

    private function onWinningTexturesReadyToBuild(instruction:WinningTexturesReadyToBuild):void {

        winningTextures = instruction.textures;
        winningTextures.buildTextures();

    }

    private function onTexturesReadyToBuild(instruction:TexturesReadyToBuild):void {

        textures = instruction.textures;
        textures.buildTextures();

    }

    override protected function init():void {

        super.init();

    }

    public function addReel(value:Vector.<String>, position:Point, gridHeight:Number):void {

        var reel:ReelRenderer = new ReelRenderer(textures, winningTextures);

        reel.x = position.x;
        reel.y = position.y;
        reel.value = value;

        reel.gridHeight = gridHeight;

        addChild(reel);

    }

    override public function dispose():void {

        super.dispose();

    }

    public function updateReelValue(id:int, value:Vector.<String>):void {

        var reel:ReelRenderer = reelsFinder.getReel(id);

        var actions:CommandQueue = new CommandQueue(false);
        actions.addCommand(new HideStarlingItems(ReelItem, reel, false));

        dispatchEvent(new CommandCallEvent(CommandCallEvent.COMMAND, actions));

        reel.value = value;

    }

    public function spinReel(id:int, value:SpinReelData):void {

        var reel:ReelRenderer = reelsFinder.getReel(id);

        reel.spinData = value;

    }

    private function onReelsReady(event:ReelsStatus):void {

        centerReels();

        reelsFinder = new ReelsFinder(this);

    }

    override protected function resize():void{

        centerReels();

    }

    private function centerReels():void {

        x = (stage.stageWidth - width) / 2;
        y = (stage.stageHeight - height) / 2;

    }

  }
}

/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/7/12
 * Time: 12:32 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels {


    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.Timer;

    import it.eurobet.core.IStarlingView;
    import it.eurobet.core.Presenter;
    import it.eurobet.games.slot.events.SlotInstructionEvent;
    import it.eurobet.games.slot.instructions.InitSlot;
    import it.eurobet.games.slot.instructions.InitTransitions;
    import it.eurobet.games.slot.instructions.SpinReels;
    import it.eurobet.games.slot.instructions.UpdateReels;
    import it.eurobet.games.slot.model.entities.Reel;
    import it.eurobet.games.slot.model.entities.WinningLine;
    import it.eurobet.games.slot.model.vos.GridInfo;
    import it.eurobet.games.slot.model.vos.SpinReelData;
    import it.eurobet.games.slot.model.vos.TweenDescription;
    import it.eurobet.games.slot.services.IProcessSequence;
    import it.eurobet.games.slot.services.RandomGenerator;
    import it.eurobet.games.slot.services.ReelSymbolsProvider;
    import it.eurobet.games.slot.services.TransitionProvider;
    import it.eurobet.games.slot.services.parsers.EvenRowParser;
    import it.eurobet.games.slot.services.parsers.OddRowParser;
    import it.eurobet.games.slot.view.reels.events.ReelsStatus;
    import it.eurobet.games.slot.view.reels.helpers.OrderProvider;

    internal class Reels extends Presenter{

    private var currentReels:Vector.<Reel>;
    private var winningLines:Vector.<WinningLine>;
    private var grid:GridInfo;

    private var reelTransition:TweenDescription;
    private var winningLineTransition:TweenDescription;
    private var winningSymbolTransition:TweenDescription;

    private const MARGIN:int = 5;
    private const REEL_DISTANCE:int = 108;

    private var timer:Timer;
    private var _reelDistance:int;
    private const SYMBOL_HEIGHT:int = 120;
    private var winningSymbols:Array;

    public function Reels(v:IStarlingView) {

        super (v);

        view.addEventListener(InitSlot.DO_HANDLE, onInitSlot);
        view.addEventListener(InitTransitions.DO_HANDLE, onInitTransitions);
        view.addEventListener(UpdateReels.DO_HANDLE, onUpdateReels);
        view.addEventListener(SpinReels.DO_HANDLE, onSpinReels);

    }

    private function onUpdateReels(instruction:UpdateReels):void {

        updateReels();

    }

    private function onSpinReels(instruction:SpinReels):void {

        winningSymbols = instruction.parameters;

        spin();

    }

    private function onInitTransitions(instruction:InitTransitions):void {

        instruction.target.removeEventListener(instruction.type, arguments.callee);

        var provider:TransitionProvider = instruction.parameters as TransitionProvider;

        reelTransition          = provider.reelTransition;
        winningLineTransition   = provider.winningLineTransition;
        winningSymbolTransition = provider.winningSymbolTransition;

    }

    private function onInitSlot(instruction:InitSlot):void {

        instruction.target.removeEventListener(instruction.type, arguments.callee);

        _origin = instruction.origin;

        currentReels = instruction.reels;
        winningLines = instruction.winningLines;
        grid = instruction.grid;

        var parser:IProcessSequence = getParser();
        var count:int = 0;

        for each(var reel:Reel in currentReels){

            var reelProvider:ReelSymbolsProvider = new ReelSymbolsProvider(parser, reel.sequence, winningSymbols);

            // From here you can control in which coordinates to add the reels
            view.addReel(reelProvider.currents(grid.rows), new Point((reelDistance * count) + MARGIN, 10), grid.rows * SYMBOL_HEIGHT);
            count++;

        }

        dispatchEvent(new ReelsStatus(ReelsStatus.REELS_READY));

    }

    private function getParser():IProcessSequence {

        var value:IProcessSequence;

        if (grid.rows % 2) {

            value = new OddRowParser();

        } else {

            value = new EvenRowParser();

        }

        return value;

    }

    private function updateReels():void{

        if(!timer){

            timer = new Timer(100, 1);
            timer.addEventListener(TimerEvent.TIMER, onUpdateIt);
            timer.start();

        }else{

            timer.stop();
            timer.addEventListener(TimerEvent.TIMER, onUpdateIt);
            timer = null;

        }

    }

    private function spin():void {

        var tot:int = currentReels.length;
        var winningCount:int = 0;

        for (var i:int = 0; i < tot; i++){

            var parser:IProcessSequence = getParser();
            var reelProvider:ReelSymbolsProvider = new ReelSymbolsProvider(parser, currentReels[i].sequence, winningSymbols);

            var random:int = new RandomGenerator(reelProvider.all.length).random;

            var value:SpinReelData = new SpinReelData();

            value.winning = reelProvider.winning(winningCount, grid.rows);
            value.moving = reelProvider.moving;
            value.heading = reelProvider.currents(2);

            winningCount += grid.rows;
            winningCount -= 1;

            /* trace('rnd', random)
            trace('---', reelProvider.winning(random, grid.rows));
            trace('---', reelProvider.moving);
            trace('---', reelProvider.currents(1));
            trace(' *** ');
            */

            view.spinReel(i, value);

            trace('winning -> ' + value.winning);

        }

        var reelsOrder:Array = new OrderProvider(tot).build();
        _origin.dispatchEvent(new SlotInstructionEvent('AnimateReels', [reelTransition, reelsOrder]));

    }

    private function onUpdateIt(e:TimerEvent):void{

        var parser:IProcessSequence = new OddRowParser();
        var count:int = 0;

        for each(var reel:Reel in currentReels){

            var reelProvider:ReelSymbolsProvider = new ReelSymbolsProvider(parser, reel.sequence, winningSymbols);
            view.updateReelValue(count, reelProvider.currents(grid.rows));

            count++;

        }

    }

    private function get reelDistance():int {

        return _reelDistance || REEL_DISTANCE;

    }

    private function get view():IReelsView{

        return _view as IReelsView;

    }

}
}

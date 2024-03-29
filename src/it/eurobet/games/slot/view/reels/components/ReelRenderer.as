/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 6/14/12
 * Time: 12:22 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.reels.components {

    import com.gnstudio.nabiro.flash.components.SmartStarlingSprite;
    import com.greensock.TimelineMax;

    import flash.display.DisplayObject;
    import flash.events.TimerEvent;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import it.eurobet.components.Symbol;
    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.core.TexturesLoader;
    import it.eurobet.games.slot.events.SlotInstructionEvent;
    import it.eurobet.games.slot.instructions.AnimateReels;
    import it.eurobet.games.slot.model.vos.Coordinates;
    import it.eurobet.games.slot.model.vos.SpinReelData;
    import it.eurobet.games.slot.model.vos.TweenDescription;
    import it.eurobet.games.slot.view.reels.events.ReelPhase;
    import it.eurobet.games.slot.view.reels.helpers.CleanAndCloneItems;

    public class ReelRenderer extends SmartStarlingSprite implements IWillBeObserved{

    private const DELTA:int = 0;
    private const TOLERANCE:int = 100;

    private var reelItems:Dictionary;

    private const EASING_SPEED:Number = .9;
    private const END_EASING_SPEED:Number = 2.2;

    private var textures:TexturesLoader;
    private var winningTextures:TexturesLoader;
    private var reelTransition:TweenDescription;
    private var reelsOrder:Array;

    private var _gridHeight:Number;
    private var _id:int;
    private var _origin:DisplayObject;

    private var initialContainer:ReelItemContainer;
    private var winningContainer:ReelItemContainer;

    private var movingContainers:Vector.<ReelItemContainer>;
    private var queuedIndexes:Vector.<int>;

    private var cleaner:CleanAndCloneItems;

    private var spinReelData:SpinReelData;
    private const CONTAINERS_TO_RENDER:int = 3;
    private const ADDITIONAL_ITEMS:int = 2;
    private var _timer:Timer;
    private var _itemsToMove:int;
    private var winningReelsTransition:TweenDescription;

    public function ReelRenderer(data:TexturesLoader, winning:TexturesLoader) {

        textures = data;
        winningTextures = winning;

        reelItems = new Dictionary(true);

        movingContainers = new Vector.<ReelItemContainer>();
        queuedIndexes = new Vector.<int>();

        addEventListener(AnimateReels.DO_HANDLE, onAnimateReels);
        addEventListener(ReelPhase.ADDED_TO_QUEUE, onCandidateReceived);
        addEventListener(ReelPhase.PROCESS_QUEUE, onProcessQueue);
        addEventListener(ReelPhase.REMOVE_FROM_QUEUE, onRemoveCandidate);
        addEventListener(ReelPhase.FINAL_TRANSITION, onFinalTransition);

    }

    private function onFinalTransition(event:ReelPhase):void {

        event.stopImmediatePropagation();

        lastMovingContainer.pause();

        var endItems:Vector.<ReelItemContainer> = new Vector.<ReelItemContainer>(3);

        endItems[0] = lastMovingContainer;
        endItems[1] = winningContainer;

        var container = createMovingContainer();
        container.y =  winningContainer.y - container.height;
        container.alpha = .4;

        addChild(container);

        endItems[2] = container;

        var initTween:TimelineMax = new TimelineMax({onComplete: endTweenCompleted});

        for each(var item:ReelItemContainer in endItems) {

            initTween.insert(new winningReelsTransition.tweener(item, winningReelsTransition.speed || END_EASING_SPEED, {y: item.y + item.height, ease: winningReelsTransition.easing}));
            trace(item.y + item.height);

        }

        initTween.play();

    }

    private function endTweenCompleted():void {

        trace(spinReelData.winningCoordinates);
        winningContainer.winning(spinReelData.winningCoordinates, winningTextures);

    }

    // TODO check if it can be deleted
    private function onRemoveCandidate(event:ReelPhase):void {

        var count:int = 0;

        for each(var item:ReelItemContainer in movingContainers){

            // trace(":::::::::::::::", item.id, (event.target as ReelItemContainer).id);

            if(item == event.target){

                movingContainers.splice(count, 1);
                break;

            }

            count++;

        }

    }

    private function onCandidateReceived(event:ReelPhase):void {

        var count:int = 0;

        for each(var item:ReelItemContainer in movingContainers){

            if(item == event.target){

                queuedIndexes.push(count);
                break;

            }

            count++;

        }

    }

    private function initEndAnimation(event:TimerEvent):void {

        event.target.removeEventListener(event.type, arguments.callee);

        winningContainer.y = lastMovingContainer.y - winningContainer.height;
        winningContainer.dispatchEvent(new ReelPhase(ReelPhase.END_MOVING));

        for each(var item:ReelItemContainer in movingContainers){

            // item.alpha = .5;
            item.remove()

        }

    }

    private function get lastMovingContainer():ReelItemContainer{

        var value:Vector.<ReelItemContainer> =  movingContainers.sort(function(a:ReelItemContainer, b:ReelItemContainer):Number{

           if(a.y > b.y){

               return 1;

           }else{

               return -1;

           }

        });

        return value[0];

    }

    private function onProcessQueue(event:ReelPhase):void {

        var statusToCheck:String;

        var recoverItems:Function = function(item:ReelItemContainer, index:int, vector:Vector.<ReelItemContainer>):Boolean {

            var value:Boolean = false;

        //    trace(item.status)

            if(item.status == statusToCheck){

                value = true;

            }

            return value;

        };

        // The items never processed
        statusToCheck = ReelItemContainer.IS_QUEUED;
        var queued:Vector.<ReelItemContainer> = movingContainers.filter(recoverItems);

        // The items outside the grid
        statusToCheck = ReelItemContainer.IS_PAUSED;
        var paused:Vector.<ReelItemContainer> = movingContainers.filter(recoverItems);

        // The items currently moving
        statusToCheck = ReelItemContainer.IS_MOVING;
        var moving:Vector.<ReelItemContainer> = movingContainers.filter(recoverItems);

        if(paused.length > 0 && moving.length < itemsToMove(moving[0])){

            paused[0].dispatchEvent(new ReelPhase(ReelPhase.MOVING, false,  lastMovingContainer.y - paused[0].height));

        }

    }

    override protected function init():void {

        _id = parent.numChildren - 1;

    }

    private function onAnimateReels(instruction:AnimateReels):void {

        if(!_origin){

            _origin = instruction.origin;

        }

        reelTransition = instruction.reelTransition;
        reelsOrder = instruction.reelsOrder;
        winningReelsTransition = instruction.winningSymbolTransition;

        var initTween:TimelineMax = new TimelineMax({onComplete: initTweenCompleted});

        for each(var item:ReelItem in reelItems) {

            initTween.insert(new reelTransition.tweener(item, EASING_SPEED, {y: item.y + (-1 * item.height), ease: reelTransition.easing}));

        }

        initTween.delay = 0.1 * startIndex;
        initTween.play();

    }

    private function resetTimer():void {

        if (_timer) {

            if (_timer.running) {

                _timer.stop();
                _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, initEndAnimation);

            }

            _timer = null;

        }

    }

    private function initTweenCompleted():void {

        initialContainer.y = targetY;
        addChild(initialContainer);

        var container:ReelItemContainer;
        var limit:int = CONTAINERS_TO_RENDER;

        for(var i:int = 0; i <= limit; i++){

            container = createMovingContainer();

            container.id = 'moving_' + i;
            container.limit = _gridHeight - TOLERANCE;

            // All the moving containers can stay the same y because the movement can start from the same position;
            container.y = initialContainer.y - (container.height * (i + 1));

            container.processQueue = true;

            movingContainers.push(container);

            addChild(container);

        }

        createWinningContainer();

        winningContainer.limit = _gridHeight - TOLERANCE;
        winningContainer.y = lastContainer.y - winningContainer.height;

        addChild(winningContainer);

        // The main animation of each reel can start, first propagates the config data then init the movement
        _origin.dispatchEvent(new SlotInstructionEvent('AnimateRenderData', [_gridHeight, reelTransition, _id, int(_gridHeight / container.height) + 1]));

        // Reset and restart the timer that states when the end animation has to start
        resetTimer();
        initTimer();

        initialContainer.dispatchEvent(new ReelPhase(ReelPhase.INIT_MOVING));

        var count:int = 0;
        var neededItems:int = itemsToMove(container);

        for each(var item:ReelItemContainer in movingContainers){

            if(count < neededItems){

                movingContainers[count].dispatchEvent(new ReelPhase(ReelPhase.INIT_MOVING));
                count++;

            }

        }

        var itemsToRemove:Vector.<ReelItemContainer> = movingContainers.splice(count,  movingContainers.length - neededItems);
        removeReels(itemsToRemove);

    }

    private function removeReels(value:Vector.<ReelItemContainer>):void{

        for each(var item:ReelItemContainer in value){

            removeChild(item);

        }

    }

    private function initTimer():void{

        _timer = new Timer(reelTransition.minDuration * 1000, 1);

        _timer.addEventListener(TimerEvent.TIMER_COMPLETE, initEndAnimation);
        _timer.start();

    }



    private function itemsToMove(container:ReelItemContainer):int {

        if(!_itemsToMove){

            _itemsToMove = int(_gridHeight / container.height) + ADDITIONAL_ITEMS;

        }

        return _itemsToMove;

    }

    private function get lastContainer():ReelItemContainer {

         var count:int = numChildren - 1;
         var item:ReelItemContainer;

         while(count >= 0){

            var currentItem:* = getChildAt(count);

            if(currentItem is ReelItemContainer){

                item = currentItem;
                break;

            }

            count--;

         }

         return item;

    }

    private function cleanContainers():void {

        if(movingContainers){

            for each(var item:ReelItemContainer in movingContainers){

                removeFromParent(item);
                item = null;

            }

            movingContainers = new Vector.<ReelItemContainer>();

        }

        if(initialContainer){

            removeFromParent(initialContainer);
            initialContainer = null;

        }

    }

    private function createWinningContainer():void {

        var winningItems:Vector.<ReelItem> = new Vector.<ReelItem>();
        var reelItem:ReelItem;

        for each (var moveItem:String in spinReelData.winning) {

            var moveSymbol:Symbol = new Symbol(textures.getTextureByName(moveItem));

            reelItem = new ReelItem(moveItem, moveSymbol);
            winningItems.push(reelItem);

        }

        winningContainer = new ReelItemContainer(winningItems);

    }

    private function createMovingContainer(data:Vector.<String> = null):ReelItemContainer {

        var movingItems:Vector.<ReelItem> =  new Vector.<ReelItem>();
        var currentItems:Vector.<String>;

        if(data){

            currentItems = data;

        }else{

            currentItems = spinReelData.moving;

        }

        var reelItem:ReelItem;

        for each (var moveItem:String in currentItems) {

            var moveSymbol:Symbol = new Symbol(textures.getTextureByName(moveItem));

            reelItem = new ReelItem(moveItem, moveSymbol);
            movingItems.push(reelItem);

        }

        return new ReelItemContainer(movingItems);

    }

    private function get startIndex():int{

        var tot:int = reelsOrder.length;
        var value:int;

        for(var i:int = 0; i < tot; i++){

            if(reelsOrder[i] == _id){

                value = i;
                break;

            }

        }

        return value;

    }

    public function set value(value:Vector.<String>):void{

        var reelItem:ReelItem;
        var currentY:int = 0;
        var count:int = 0;

        for each(var item:String in value){

            if(reelItem){

                currentY = reelItem.y + reelItem.height + DELTA;

            }

            var symbol:Symbol = new Symbol(textures.getTextureByName(item));

            reelItem = new ReelItem(item,  symbol);
            reelItem.y = currentY;

            reelItems[count] = reelItem;
            count++;

            addChild(reelItem);

        }

    }

    public function set spinData(value:SpinReelData):void{

        // trace(' SETTO I DATI NEL RENDERER');

        spinReelData = value;

        var reelItem:ReelItem = getChildAt(numChildren - 1) as ReelItem;
        var currentY:int = 0;
        var count:int = numChildren;

        for each(var item:String in value.heading){

            if(reelItem){

                currentY = reelItem.y + reelItem.height + DELTA;

            }

            var symbol:Symbol = new Symbol(textures.getTextureByName(item));

            reelItem = new ReelItem(item,  symbol);
            reelItem.y = currentY;

            reelItems[count] = reelItem;
            count++;

            addChild(reelItem);

        }

        if(cleaner){

            cleaner = null;

        }

        cleaner = new CleanAndCloneItems(this);

        var items:Vector.<ReelItem> = cleaner.getItems();

        if(initialContainer){

            initialContainer.removeFromParent(true);
            initialContainer = null;

        }

        initialContainer = new ReelItemContainer(items);

    }

    public function get id():int{

        return _id;

    }

    public function set gridHeight(value:Number):void{

        _gridHeight = value;

    }

    private function get targetY():Number{

        return getChildAt(0).y;

    }

    }
}

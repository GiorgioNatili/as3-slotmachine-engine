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
    import com.greensock.TweenMax;

    import flash.display.DisplayObject;
    import flash.trace.Trace;
    import flash.utils.Dictionary;

    import it.eurobet.components.Symbol;
    import it.eurobet.core.IWillBeObserved;
    import it.eurobet.core.TexturesLoader;
    import it.eurobet.games.slot.events.SlotInstructionEvent;
    import it.eurobet.games.slot.instructions.AnimateReels;
    import it.eurobet.games.slot.model.entities.Reel;
    import it.eurobet.games.slot.model.vos.SpinReelData;
    import it.eurobet.games.slot.model.vos.TweenDescription;
    import it.eurobet.games.slot.view.reels.components.ReelItem;
    import it.eurobet.games.slot.view.reels.events.ReelPhase;
    import it.eurobet.games.slot.view.reels.events.ReelsStatus;
    import it.eurobet.games.slot.view.reels.helpers.CleanAndCloneItems;
    import it.eurobet.utils.VectorRandomizer;

    import starling.display.Quad;

    public class ReelRenderer extends SmartStarlingSprite implements IWillBeObserved{

    private const DELTA:int = 0;

    private var reelItems:Dictionary;

    private const EASING_SPEED:Number = .9;
    private const END_EASING_SPEED:Number = .9;

    private var textures:TexturesLoader;
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


    public function ReelRenderer(data:TexturesLoader) {

        textures = data;

        reelItems = new Dictionary(true);

        movingContainers = new Vector.<ReelItemContainer>();
        queuedIndexes = new Vector.<int>();

        addEventListener(AnimateReels.DO_HANDLE, onAnimateReels);
        addEventListener(ReelPhase.ADDED_TO_QUEUE, onCandidateReceived);
        addEventListener(ReelPhase.PROCESS_QUEUE, onProcessQueue);

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

        if(queued.length > 0 && moving.length < itemsToMove(moving[0])){

            queued[0].y = moving[moving.length - 1].y - queued[0].height;
            queued[0].dispatchEvent(new ReelPhase(ReelPhase.INIT_MOVING));
            trace('Playing with the queue ', moving.length + '|' + queued.length, moving[0].y,  moving[moving.length - 1].y)

        }else if(paused.length > 0){

            if(moving.length < itemsToMove(moving[0])){

                paused[0].dispatchEvent(new ReelPhase(ReelPhase.MOVING, false,  moving[0].y - paused[0].height));

            }

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

        var initTween:TimelineMax = new TimelineMax({onComplete: initTweenCompleted});

        for each(var item:ReelItem in reelItems) {

            initTween.insert(new reelTransition.tweener(item, EASING_SPEED, {y: item.y + (-1 * item.height), ease: reelTransition.easing}));

        }

        initTween.delay = 0.1 * startIndex;
        initTween.play();

    }

    private function initTweenCompleted():void {

        initialContainer.y = targetY;
        addChild(initialContainer);

        var container:ReelItemContainer;
        var limit:int = CONTAINERS_TO_RENDER;

        for(var i:int = 0; i <= limit; i++){

            container = createMovingContainer();

            container.limit = _gridHeight;

            // All the moving containers can stay the same y because the movement can start from the same position;
            container.y = initialContainer.y - container.height;

            container.processQueue = true;

            movingContainers.push(container);

            addChild(container);

        }

        createWinningContainer();

        winningContainer.limit = _gridHeight;
        winningContainer.y = lastContainer.y - winningContainer.height;

        addChild(winningContainer);

        // The main animation of each reel can start, first propagates the config data then init the movement
        _origin.dispatchEvent(new SlotInstructionEvent('AnimateRenderData', [_gridHeight, reelTransition, _id, int(_gridHeight / container.height) + 1]));

        initialContainer.dispatchEvent(new ReelPhase(ReelPhase.INIT_MOVING));

        var count:int = 0;
        for each(var item:ReelItemContainer in movingContainers){

            if(count < itemsToMove(container)){

                container.dispatchEvent(new ReelPhase(ReelPhase.INIT_MOVING));

            }

            count++;

        }

    }

    private function itemsToMove(container:ReelItemContainer):int {

        return int(_gridHeight / container.height) + 1;

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

        trace(' SETTO I DATI NEL RENDERER');

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

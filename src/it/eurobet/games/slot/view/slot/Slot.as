/**
 * Created with IntelliJ IDEA.
 * User: giorgionatili
 * Date: 8/19/12
 * Time: 4:21 PM
 * To change this template use File | Settings | File Templates.
 */
package it.eurobet.games.slot.view.slot {

    import it.eurobet.core.IStarlingView;
    import it.eurobet.core.Presenter;
    import it.eurobet.games.slot.events.DataEvent;
    import it.eurobet.games.slot.events.PlaceBetData;
    import it.eurobet.games.slot.events.SlotInstructionEvent;
    import it.eurobet.games.slot.instructions.InitSlot;
    import it.eurobet.games.slot.services.PlaceBetProvider;

    internal class Slot extends Presenter{

        public function Slot(v:IStarlingView) {

            super (v);

            view.addEventListener(InitSlot.DO_HANDLE, onInitSlot);

        }

        private function onInitSlot(instruction:InitSlot):void {

            instruction.target.removeEventListener(instruction.type, arguments.callee);

            _origin = instruction.origin;

        }

        public function updateReels():void {

            _origin.dispatchEvent(new SlotInstructionEvent('UpdateReels'));

        }

        public function spin():void {

            var placeBet:PlaceBetProvider = new PlaceBetProvider('placebet.xml');

            placeBet.addEventListener(PlaceBetData.READY, onPlaceBetDataReady);
            placeBet.addEventListener(PlaceBetData.FAULT, onPlaceBetDataFault);

            placeBet.load();

        }

        private function onPlaceBetDataFault(event:PlaceBetData):void {

            event.target.removeEventListener(event.type, arguments.callee);

           trace('Data are not loaded from the SPIN');

        }

        private function onPlaceBetDataReady(event:PlaceBetData):void {

            event.target.removeEventListener(event.type, arguments.callee);

            var provider:PlaceBetProvider = (event.target as PlaceBetProvider);

            _origin.dispatchEvent(new SlotInstructionEvent('SpinReels', [provider.winningItems, provider.winningLine]));

        }

        private function get view():ISlotView{

            return _view as ISlotView;

        }

    }
}

package game.step
{

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;

    import game.GameModel;
    import game.player.Player;

    import map.cell.Cell;
    import map.cell.type.TransporterCell;

    import postOffice.GameEvent;

    import tool.DisplayUtil;

    /**
     * @author Drew
     */
    public class TransportersStep extends GameStep
    {
        private var _transporterInfoArray: Array;

        public function TransportersStep(post: EventDispatcher, gameModel: GameModel)
        {
            super(post, gameModel, 1000);
        }

        override protected function onStart(): void
        {
            super.onStart();

            _transporterInfoArray = [];

            for each(var player: Player in gameModel.players) {
                var cellUnderPlayer: Cell = gameModel.map.findCell(player.cell.x, player.cell.y);
                startTransporter(player, cellUnderPlayer as TransporterCell);
            }

            post.dispatchEvent(new GameEvent(GameEvent.ON_TRANSPORTERS_STEP_START, this));
        }

        private function startTransporter(player: Player, transporterCell: TransporterCell): void
        {
            if (transporterCell == null) {
                return;
            }

            _transporterInfoArray.push({
                player: player,
                transporter: transporterCell
            });

            DisplayUtil.addStroke(transporterCell);
        }

        private function finishTransporter(): void
        {
            for each(var transporterInfo: Object in _transporterInfoArray) {
                transporterInfo.player.cell.moveBy(transporterInfo.transporter.directionInformation.direction);

                DisplayUtil.removeStroke(transporterInfo.transporter);
            }
        }

        override protected function onCompleteTimer(event: TimerEvent): void
        {
            super.onCompleteTimer(event);

            finishTransporter();

            finish();
        }
    }
}

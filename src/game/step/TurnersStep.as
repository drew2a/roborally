package game.step
{

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;

    import game.GameModel;
    import game.player.Player;

    import map.cell.Cell;
    import map.cell.type.TurnerCell;

    import postOffice.GameEvent;

    import tool.DisplayUtil;

    /**
     * @author Drew
     */
    public class TurnersStep extends GameStep
    {
        private var _turnerInfoArray: Array;

        public function TurnersStep(post: EventDispatcher, gameModel: GameModel)
        {
            super(post, gameModel, 1000);
        }

        override protected function onStart(): void
        {
            super.onStart();

            _turnerInfoArray = [];

            for each(var player: Player in gameModel.players) {
                var cellUnderPlayer: Cell = gameModel.map.findCell(player.cell.x, player.cell.y);
                startTurn(player, cellUnderPlayer as TurnerCell);
            }

            post.dispatchEvent(new GameEvent(GameEvent.ON_TRANSPORTERS_STEP_START, this));
        }

        private function startTurn(player: Player, turnerCell: TurnerCell): void
        {
            if (turnerCell == null) {
                return;
            }

            _turnerInfoArray.push({
                player: player,
                turner: turnerCell
            });

            DisplayUtil.addStroke(turnerCell);
        }

        private function finishTurners(): void
        {
            for each(var turnerInfo: Object in _turnerInfoArray) {
                DisplayUtil.removeStroke(turnerInfo.turner);

                if (turnerInfo.turner.CW) {
                    turnerInfo.player.cell.right();
                    return;
                }

                turnerInfo.player.cell.left();
            }
        }

        override protected function onCompleteTimer(event: TimerEvent): void
        {
            super.onCompleteTimer(event);

            finishTurners();

            finish();
        }
    }
}

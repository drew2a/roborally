package stack
{

    import flash.events.EventDispatcher;

    import game.player.Player;

    import postOffice.GameEvent;

    import map.cell.Cell;
    import map.cell.CellFactory;
    import map.cell.type.EmptyCell;

    import game.card.Card;

    import ui.UserInterface;

    /**
     * @author Drew
     */
    public class PlayerStack extends Stack
    {
        public function PlayerStack(userInterface: UserInterface, post: EventDispatcher)
        {
            super(userInterface, post, Player.MAX_STACK_SIZE);
        }

        override protected function init(): void
        {
            super.init();

            createBackGround();
            post.addEventListener(GameEvent.ON_CREATE_INCOMING_STACK, onCreateStack);
            post.addEventListener(GameEvent.ON_HUMAN_PLAYER_READY, onPlayerReady);
        }

        override public function add(stackCell: Card): void
        {
            super.add(stackCell);
            checkLast();
        }

        override public function remove(stackCell: Card): void
        {
            super.remove(stackCell);
            checkLast();
        }

        private function createBackGround(): void
        {
            for (var i: int = 0; i < maxLength; i++) {
                var cell: Cell = CellFactory.create(EmptyCell.NAME);

                cell.x = i * (Card.SIZE + DISTANCE_BETWEEN_CELLS);
                cell.y = 0;

                addChild(cell);
            }
        }

        private function checkLast(): void
        {
            if (maxLength == items.length) {
                post.dispatchEvent(new GameEvent(GameEvent.ON_STACK_COMPLETE, items));
                return;
            }

            post.dispatchEvent(new GameEvent(GameEvent.ON_STACK_NOT_COMPLETE));
        }

        private function onPlayerReady(event: GameEvent): void
        {
            disable();
        }

        private function onCreateStack(event: GameEvent): void
        {
            clear();
        }
    }
}

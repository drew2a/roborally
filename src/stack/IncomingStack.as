package stack
{

    import flash.events.EventDispatcher;

    import postOffice.GameEvent;

    import game.card.Card;

    import ui.UserInterface;

    /**
     * @author Drew
     */
    public class IncomingStack extends Stack
    {
        public static const MAX_LENGTH: int = 8;

        public function IncomingStack(userInterface: UserInterface, post: EventDispatcher)
        {
            super(userInterface, post, MAX_LENGTH);
        }

        override protected function init(): void
        {
            super.init();

            post.addEventListener(GameEvent.ON_CREATE_INCOMING_STACK, onCreate);
            post.addEventListener(GameEvent.ON_HUMAN_PLAYER_READY, onPlayerReady);
        }

        private function create(array: Array): void
        {
            if (array == null) {
                return;
            }

            for each(var object: Object in array) {
                var cell: Card = object as Card;
                if (cell == null) {
                    continue;
                }

                cell.owner = this;
                cell.target = userInterface.playerStack;

                items.push(cell);
            }
        }

        private function onPlayerReady(event: GameEvent): void
        {
            clear();
        }

        private function onCreate(event: GameEvent): void
        {
            removeDisplayObjects();
            items = [];
            create(event.object as Array);
            createDisplayObjects()
        }
    }
}

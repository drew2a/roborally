package stack
{

    import flash.events.EventDispatcher;

    import postOffice.GameEvent;

    import game.card.Card;

    import ui.StageObject;
    import ui.UserInterface;

    /**
     * @author Drew
     */
    public class Stack extends StageObject
    {
        public static const DISTANCE_BETWEEN_CELLS: int = 5;

        private var _items: Array = [];
        private var _maxLength: int = 0;
        private var _userInterface: UserInterface;
        private var _post: EventDispatcher;

        public function Stack(userInterface: UserInterface, post: EventDispatcher, maxLength: int)
        {
            _userInterface = userInterface;
            _post = post;
            _maxLength = maxLength;

            _post.addEventListener(GameEvent.ON_ROUND_START, onRoundStart);
        }

        public function clear(): void
        {
            removeDisplayObjects();
            items = [];
        }

        public function disable(): void
        {
            for each(var item: Card in _items) {
                item.enable = false;
            }
        }

        public function remove(stackCell: Card): void
        {
            if (stackCell == null) {
                return;
            }

            removeDisplayObjects();
            _items.splice(_items.indexOf(stackCell), 1);
            createDisplayObjects();
        }

        public function canAdd(): Boolean
        {
            return _items.length < _maxLength;
        }

        public function add(stackCell: Card): void
        {
            if (stackCell == null) {
                return;
            }

            removeDisplayObjects();
            _items.push(stackCell);
            createDisplayObjects();
        }

        public function createDisplayObjects(): void
        {
            var index: int = 0;
            for each(var item: Card in _items) {
                item.x = index * (Card.SIZE + DISTANCE_BETWEEN_CELLS);

                index++;
                addChild(item);
            }
        }

        public function removeDisplayObjects(): void
        {
            for each(var item: Card in _items) {
                if (contains(item)) {
                    removeChild(item);
                }
            }
        }

        private function onRoundStart(event: GameEvent): void
        {
            disable();
        }

        public function get items(): Array
        {
            return _items;
        }

        public function set items(value: Array): void
        {
            _items = value;
        }

        public function get userInterface(): UserInterface
        {
            return _userInterface;
        }

        public function get maxLength(): int
        {
            return _maxLength;
        }

        public function get post(): EventDispatcher
        {
            return _post;
        }
    }
}

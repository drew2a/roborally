package game.player
{

    import flash.events.EventDispatcher;

    import game.GameModel;
    import game.card.Card;

    import map.cell.type.PlayerCell;

    /**
     * @author Drew
     */
    public class Player extends EventDispatcher
    {
        public static const MAX_STACK_SIZE: int = 5;
        private var _playerType: String;
        private var _post: EventDispatcher;
        private var _gameModel: GameModel;
        private var _cell: PlayerCell;
        private var _incomingStack: Array;
        private var _stack: Array;
        private var _ready: Boolean = false;

        public function load(playerObject: Object): void
        {
            var cellConfig: Object = playerObject.cell;
            _cell = _gameModel.map.createCell(cellConfig, cellConfig.x, cellConfig.y) as PlayerCell;
        }

        public function init(): void
        {

        }

        public function addIncomingStack(stack: Array): void
        {
            _incomingStack = stack;
            for each(var card: Card in _incomingStack) {
                card.player = this;
            }
        }

        public function set playerType(value: String): void
        {
            _playerType = value;
        }

        public function get post(): EventDispatcher
        {
            return _post;
        }

        public function set post(post: EventDispatcher): void
        {
            _post = post;
        }

        public function get gameModel(): GameModel
        {
            return _gameModel;
        }

        public function set gameModel(value: GameModel): void
        {
            _gameModel = value;
        }

        public function get cell(): PlayerCell
        {
            return _cell;
        }

        public function get stack(): Array
        {
            return _stack;
        }

        public function set stack(value: Array): void
        {
            _stack = value;
        }

        public function get ready(): Boolean
        {
            return _ready;
        }

        public function set ready(value: Boolean): void
        {
            _ready = value;
        }

        public function get incomingStack(): Array
        {
            return _incomingStack;
        }
    }
}

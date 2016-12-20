package game
{

    import flash.events.EventDispatcher;

    import game.card.CardDeck;
    import game.player.Player;
    import game.round.GameRound;

    import postOffice.GameEvent;

    import stack.IncomingStack;

    /**
     * @author Drew
     */
    public class GameEngine
    {
        private var _post: EventDispatcher;
        private var _gameModel: GameModel;

        public function GameEngine(post: EventDispatcher, gameModel: GameModel)
        {
            _post = post;
            _gameModel = gameModel;
        }

        public function start(): void
        {
            _post.addEventListener(GameEvent.ON_ROUND_FINISH, onRoundFinish);
            _post.addEventListener(GameEvent.ON_GAME_START, onGameStart);
            _post.addEventListener(GameEvent.ON_PLAYER_READY, onPlayerReady);

            _post.dispatchEvent(new GameEvent(GameEvent.ON_GAME_START));
            _post.dispatchEvent(new GameEvent(GameEvent.ON_POWER_UP));
        }

        private function allPlayersReady(): Boolean
        {
            for each(var player: Player in _gameModel.players) {
                if (!player.ready) {
                    return false;
                }
            }

            return true;
        }

        private function createIncomingStack(): void
        {
            var cardDeck: CardDeck = new CardDeck();
            cardDeck.init();
            cardDeck.mix();

            for each(var player: Player in _gameModel.players) {
                var playerStack: Array = [];

                for (var i: int = 0; i < IncomingStack.MAX_LENGTH; i++) {
                    playerStack.push(cardDeck.cards.pop());
                }

                player.addIncomingStack(playerStack);
            }
        }

        private function onPlayerReady(event: GameEvent): void
        {
            if (!allPlayersReady()) {
                return;
            }

            var round: GameRound = new GameRound(_post, _gameModel);
            round.start();
        }

        private function onGameStart(event: GameEvent): void
        {
            createIncomingStack()
        }

        private function onRoundFinish(event: GameEvent): void
        {
            createIncomingStack();
        }

        public function get gameModel(): GameModel
        {
            return _gameModel;
        }

        public function set gameModel(value: GameModel): void
        {
            _gameModel = value;
        }
    }
}

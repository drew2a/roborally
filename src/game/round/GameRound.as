package game.round
{

    import flash.events.EventDispatcher;

    import game.GameModel;
    import game.card.Card;
    import game.player.Player;
    import game.step.GameStep;
    import game.step.LasersStep;
    import game.step.MoveStep;
    import game.step.TransportersStep;
    import game.step.TurnersStep;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class GameRound
    {
        private var _post: EventDispatcher;

        private var _items: Array;
        private var _steps: Array;
        private var _gameModel: GameModel;

        public function GameRound(post: EventDispatcher, gameModel: GameModel)
        {
            _post = post;
            _gameModel = gameModel;

            post.addEventListener(GameEvent.ON_STEP_START, onStepStart);
            post.addEventListener(GameEvent.ON_STEP_FINISH, onStepFinish);
        }

        public function start(): void
        {
            _steps = [];

            var attempts: int = 10;
            while (attempts > 0) {
                var stack: Array = calculateStack();
                if (stack.length == 0) {
                    break;
                }

                _steps.push(new MoveStep(_post, _gameModel, stack));
                _steps.push(new TransportersStep(_post, _gameModel));
                _steps.push(new TurnersStep(_post, _gameModel));
                _steps.push(new LasersStep(_post, _gameModel));

                attempts--;
            }

            onRoundStart();
        }

        private function calculateStack(): Array
        {
            var stack: Array = [];
            for each(var player: Player in _gameModel.players) {
                if (player.stack == null) {
                    continue;
                }

                var card: Card = player.stack.shift();
                if (card == null) {
                    continue;
                }
                stack.push(card);
            }

            stack.sortOn(["priority"], Array.DESCENDING | Array.NUMERIC);

            return stack;
        }

        private function onRoundStart(): void
        {
            _post.dispatchEvent(new GameEvent(GameEvent.ON_ROUND_START));

            startNext();
        }

        private function startNext(): void
        {
            if (_steps == null) {
                onRoundFinish();
                return;
            }
            var step: GameStep = _steps.shift();
            if (step == null) {
                onRoundFinish();
                return;
            }

            step.start();
        }

        private function onRoundFinish(): void
        {
            _post.removeEventListener(GameEvent.ON_STEP_START, onStepStart);
            _post.removeEventListener(GameEvent.ON_STEP_FINISH, onStepFinish);

            _post.dispatchEvent(new GameEvent(GameEvent.ON_ROUND_FINISH, this));
        }

        private function onStepFinish(event: GameEvent): void
        {
            startNext();
        }

        private function onStepStart(event: GameEvent): void
        {

        }

        public function set items(value: Array): void
        {
            _items = value;
        }
    }
}

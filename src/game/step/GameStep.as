package game.step
{

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import game.GameModel;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class GameStep
    {
        private var _post: EventDispatcher;
        private var _gameModel: GameModel;
        private var _completeTime: int;
        private var _timer: Timer;

        public function GameStep(post: EventDispatcher, gameModel: GameModel, completeTime: int = 0)
        {
            _post = post;
            _gameModel = gameModel;
            _completeTime = completeTime;
        }

        public function start(): void
        {
            onStart();

            _post.dispatchEvent(new GameEvent(GameEvent.ON_STEP_START, this));
            startTimer();
        }

        public function finish(): void
        {
            onFinish();
            _post.dispatchEvent(new GameEvent(GameEvent.ON_STEP_FINISH, this));
        }

        protected function onStart(): void
        {

        }

        protected function onFinish(): void
        {

        }

        private function startTimer(): void
        {
            var timerIsSwitchedOn: Boolean = _completeTime <= 0;
            if (timerIsSwitchedOn) {
                return;
            }

            _timer = new Timer(_completeTime, 1);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onCompleteTimer);
            _timer.start();
        }

        protected function onCompleteTimer(event: TimerEvent): void
        {
            _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onCompleteTimer);
        }

        public function get post(): EventDispatcher
        {
            return _post;
        }

        public function get gameModel(): GameModel
        {
            return _gameModel;
        }
    }
}

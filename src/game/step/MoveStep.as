package game.step
{

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import game.GameModel;
    import game.card.Card;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class MoveStep extends GameStep
    {
        private var _items: Array;

        public function MoveStep(post: EventDispatcher, gameModel: GameModel, items: Array)
        {
            super(post, gameModel);
            _items = items;
        }

        override protected function onStart(): void
        {
            super.onStart();

            if (_items == null || _items.length == 0) {
                finish();
                return;
            }

            startTimer();
            post.dispatchEvent(new GameEvent(GameEvent.ON_MOVE_STEP_START, this));
        }

        private function startTimer(): void
        {
            var timer: Timer = new Timer(1000, _items.length);
            timer.addEventListener(TimerEvent.TIMER, onNextStackItem);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onStackTimerComplete);
            timer.start();
        }

        private function onNextStackItem(event: TimerEvent): void
        {
            var item: Card = _items.shift();
            if (item == null) {
                return;
            }

            item.select();
            item.doAction(gameModel.map);
        }

        private function onStackTimerComplete(event: TimerEvent): void
        {
            finish();
        }
    }
}
package game.step
{

    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;

    import game.GameModel;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class LasersStep extends GameStep
    {
        public function LasersStep(post: EventDispatcher, gameModel: GameModel)
        {
            super(post, gameModel, 2000);
        }

        override protected function onStart(): void
        {
            super.onStart();
            post.dispatchEvent(new GameEvent(GameEvent.ON_LASER_STEP_START, this));
            post.dispatchEvent(new GameEvent(GameEvent.ON_START_FIRE));
        }


        override protected function onCompleteTimer(event: TimerEvent): void
        {
            super.onCompleteTimer(event);
            post.dispatchEvent(new GameEvent(GameEvent.ON_FINISH_FIRE));

            finish();
        }
    }
}

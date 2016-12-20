package game.player
{

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class Human extends Player
    {
        public static var NAME: String = "human";

        override public function init(): void
        {
            super.init();
            post.addEventListener(GameEvent.ON_HUMAN_PLAYER_READY, onPlayerReady);
            post.addEventListener(GameEvent.ON_STACK_COMPLETE, onStackComplete);
        }

        override public function addIncomingStack(stack: Array): void
        {
            super.addIncomingStack(stack);
            post.dispatchEvent(new GameEvent(GameEvent.ON_CREATE_INCOMING_STACK, stack));
        }

        private function onStackComplete(event: GameEvent): void
        {
            var playerStack: Array = event.object as Array;
            if (playerStack == null) {
                return;
            }

            stack = playerStack.concat();
        }

        private function onPlayerReady(event: GameEvent): void
        {
            ready = true;
            post.dispatchEvent(new GameEvent(GameEvent.ON_PLAYER_READY));
        }
    }
}

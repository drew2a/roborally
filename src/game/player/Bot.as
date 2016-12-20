package game.player
{


    /**
     * @author Drew
     */
    public class Bot extends Player
    {
        public static var NAME: String = "bot";

        override public function addIncomingStack(stack: Array): void
        {
            super.addIncomingStack(stack);

            selectCards();

            ready = true;
        }

        private function selectCards(): void
        {
            stack = [];

            for (var i: int = 0; i < Player.MAX_STACK_SIZE; i++) {
                stack.push(incomingStack.pop());
            }
        }
    }
}

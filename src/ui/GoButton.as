package ui
{

    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

    import postOffice.GameEvent;

    import tool.DisplayUtil;

    /**
     * @author Drew
     */
    public class GoButton extends StageObject
    {
        private var _post: EventDispatcher;

        public function GoButton(post: EventDispatcher)
        {
            _post = post;
        }

        override protected function init(): void
        {
            super.init();
            visible = false;

            addChild(new EmbedClasses.goButton);

            _post.addEventListener(GameEvent.ON_STACK_NOT_COMPLETE, onStackNotComplete);
            _post.addEventListener(GameEvent.ON_STACK_COMPLETE, onStackComplete);

            addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            addEventListener(MouseEvent.CLICK, onMouseClick);
        }

        private function onMouseClick(event: MouseEvent): void
        {
            _post.dispatchEvent(new GameEvent(GameEvent.ON_HUMAN_PLAYER_READY));
            visible = false;
        }

        private function onMouseOver(event: MouseEvent): void
        {
            DisplayUtil.addStroke(this);
        }

        private function onMouseOut(event: MouseEvent): void
        {
            DisplayUtil.removeStroke(this);
        }

        private function onStackComplete(event: GameEvent): void
        {
            visible = true;
        }

        private function onStackNotComplete(event: GameEvent): void
        {
            visible = false;
        }
    }
}

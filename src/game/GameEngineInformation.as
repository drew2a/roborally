package game
{

    import flash.events.EventDispatcher;
    import flash.text.TextField;

    import postOffice.GameEvent;

    import tool.TextUtil;

    import ui.StageObject;

    /**
     * @author Drew
     */
    public class GameEngineInformation extends StageObject
    {
        private var _post: EventDispatcher;
        private var _info: TextField;

        public function GameEngineInformation(post: EventDispatcher)
        {
            _post = post;
        }

        override protected function init(): void
        {
            super.init();
            createTextFields();

            _post.addEventListener(GameEvent.ON_STACK_NOT_COMPLETE, onStackNotComplete);
            _post.addEventListener(GameEvent.ON_STACK_COMPLETE, onStackCompleteReady);
            _post.addEventListener(GameEvent.ON_HUMAN_PLAYER_READY, onPlayerReady);
            _post.addEventListener(GameEvent.ON_CREATE_INCOMING_STACK, onCreateIncomingStack);

            _post.addEventListener(GameEvent.ON_LASER_STEP_START, onLasersStep);
            _post.addEventListener(GameEvent.ON_MOVE_STEP_START, onMoveStep);
            _post.addEventListener(GameEvent.ON_TURNERS_STEP_START, onTurnersStep);
            _post.addEventListener(GameEvent.ON_TRANSPORTERS_STEP_START, onTransporterStep);
        }

        private function createTextFields(): void
        {
            var textField: TextField = TextUtil.createText("Ход игры:", 0x222222, 30, true);
            textField.width = 200;
            addChild(textField);

            _info = TextUtil.createText("Выбери карты, которыми будешь ходить", 0x222222, 18, true, true);
            _info.x = 0;
            _info.y = 60;
            _info.width = 200;
            _info.height = 200;
            addChild(_info);
        }

        private function onLasersStep(event: GameEvent): void
        {
            _info.text = "Лазеры стреляют";
        }

        private function onMoveStep(event: GameEvent): void
        {
            _info.text = "Роботы ходят";
        }

        private function onTurnersStep(event: GameEvent): void
        {
            _info.text = "Поворачивалки поворачивают";
        }

        private function onTransporterStep(event: GameEvent): void
        {
            _info.text = "Транспортеры транспортируют";
        }

        private function onCreateIncomingStack(event: GameEvent): void
        {
            _info.text = "Выбери карты, которыми будешь ходить";
        }

        private function onPlayerReady(event: GameEvent): void
        {
            _info.text = "";
        }

        private function onStackCompleteReady(event: GameEvent): void
        {
            _info.text = "Проверь последовательность и нажми GO (начнется ход)";
        }

        private function onStackNotComplete(event: GameEvent): void
        {
            _info.text = "Для начала хода набери полный стек";
        }
    }
}

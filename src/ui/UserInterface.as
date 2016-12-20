package ui
{

    import flash.display.Bitmap;
    import flash.events.EventDispatcher;

    import game.GameEngineInformation;
    import game.GameModel;

    import stack.IncomingStack;
    import stack.PlayerStack;

    /**
     * @author Drew
     */
    public class UserInterface extends StageObject
    {
        private static const LEFT: int = 50;
        private var _post: EventDispatcher;
        private var _playerStack: PlayerStack;
        private var _gameModel: GameModel;

        public function UserInterface(post: EventDispatcher, gameModel: GameModel)
        {
            _post = post;
            _gameModel = gameModel;
        }

        override protected function init(): void
        {
            super.init();

            createBackGround();
            createGameMap();
            createGoButton();
            createIncomingStack();
            createPlayerStack();
            createInformation();
            createHealthInformation();
        }

        private function createHealthInformation(): void
        {
            var healthPanel: HealthPanel = new HealthPanel(_post);
            healthPanel.x = LEFT;
            healthPanel.y = _gameModel.map.y + _gameModel.map.height + 30;
            addChild(healthPanel);
        }

        private function createInformation(): void
        {
            var gameEngineInformation: GameEngineInformation = new GameEngineInformation(_post);
            gameEngineInformation.x = 580;
            gameEngineInformation.y = 100;
            addChild(gameEngineInformation);
        }

        private function createPlayerStack(): void
        {
            _playerStack = new PlayerStack(this, _post);
            _playerStack.x = LEFT;
            _playerStack.y = 670;
            addChild(_playerStack);
        }

        private function createIncomingStack(): void
        {
            var incomingStack: IncomingStack = new IncomingStack(this, _post);
            incomingStack.x = LEFT;
            incomingStack.y = 620;
            addChild(incomingStack);
        }

        private function createGoButton(): void
        {
            var goButton: GoButton = new GoButton(_post);
            goButton.x = 500;
            goButton.y = 620;
            addChild(goButton);
        }

        private function createGameMap(): void
        {
            _gameModel.map.x = LEFT;
            _gameModel.map.y = 20;
            addChild(_gameModel.map);
        }

        private function createBackGround(): void
        {
            addChild(new EmbedClasses.background);
            var line: Bitmap = new EmbedClasses.line;
            line.y = -10;
            addChild(line);
        }

        public function get playerStack(): PlayerStack
        {
            return _playerStack;
        }

    }
}

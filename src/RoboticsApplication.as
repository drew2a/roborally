package
{

    import flash.events.EventDispatcher;

    import game.GameEngine;
    import game.GameModel;

    import postOffice.GamePost;

    import ui.StageObject;
    import ui.UserInterface;

    /**
     * @author Drew
     */
    public class RoboticsApplication extends StageObject
    {
        public static var post: EventDispatcher = new GamePost();
        private var _gameEngine: GameEngine;

        override protected function init(): void
        {
            super.init();

            var gameModel: GameModel = new GameModel(post);

            gameModel.loadMap(new EmbedClasses.demoMap);
            gameModel.loadPlayers(new EmbedClasses.demoMap);

            _gameEngine = new GameEngine(post, gameModel);

            var userInterface: UserInterface = new UserInterface(post, gameModel);
            addChild(userInterface);

            _gameEngine.start();
        }
    }
}

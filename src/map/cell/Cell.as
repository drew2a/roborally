package map.cell
{

    import map.GameMap;

    import ui.StageObject;

    /**
     * @author Drew
     */
    public class Cell extends StageObject
    {
        public static const SIZE: int = 42;

        private var _cellName: String;
        private var _gameMap: GameMap;

        public function Cell(name: String)
        {
            _cellName = name;
        }

        override protected function init(): void
        {
            super.init();
        }

        public function load(cellConfig: Object): void
        {

        }

        public function get gameMap(): GameMap
        {
            return _gameMap;
        }

        public function set gameMap(gameMap: GameMap): void
        {
            _gameMap = gameMap;
        }

        public function get cellName(): String
        {
            return _cellName;
        }
    }
}

package map
{

    import flash.events.EventDispatcher;
    import flash.geom.Rectangle;

    import map.cell.Cell;
    import map.cell.CellFactory;

    import ui.StageObject;

    /**
     * @author Drew
     */
    public class GameMap extends StageObject
    {
        public static const DISTANCE_BETWEEN_CELLS: int = 0;
        private var _post: EventDispatcher;
        private var _cells: Array = [];

        public function GameMap(post: EventDispatcher)
        {
            _post = post;
        }

        public static function scaleCoordinate(coordinate: int): int
        {
            return coordinate * (Cell.SIZE + DISTANCE_BETWEEN_CELLS);
        }

        public function findCell(x: int, y: int): Cell
        {
            for each(var cell: Cell in _cells) {
                if (cell.x == x && cell.y == y) {
                    return cell;
                }
            }

            return null;
        }

        public function load(demoMap: String): void
        {
            var mapConfig: Object = JSON.parse(demoMap);
            var dimensions: Rectangle = new Rectangle(0, 0, mapConfig.cols, mapConfig.rows);

            for (var x: int = dimensions.x; x < dimensions.width; x++) {
                for (var y: int = dimensions.y; y < dimensions.height; y++) {
                    var cellConfig: Object = mapConfig.cells[y * dimensions.width + x];
                    if (cellConfig == null) {
                        continue;
                    }

                    addCell(cellConfig, x, y);
                }
            }
        }

        public function createCell(cellConfig: Object, x: int, y: int): Cell
        {
            var cell: Cell = CellFactory.create(cellConfig.type);
            if (cell == null) {
                return null;
            }

            cell.load(cellConfig);
            cell.x = scaleCoordinate(x);
            cell.y = scaleCoordinate(y);
            cell.gameMap = this;
            addChild(cell);

            return cell;
        }

        public function addCell(cellObject: Object, x: int, y: int): Cell
        {
            var cell: Cell = createCell(cellObject, x, y);
            if (cell != null) {
                _cells.push(cell);
            }

            return cell;
        }

        public function get cells(): Array
        {
            return _cells;
        }

        public function get post(): EventDispatcher
        {
            return _post;
        }
    }
}

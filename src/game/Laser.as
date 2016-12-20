package game
{

    import flash.display.DisplayObject;
    import flash.display.Shape;

    import map.GameMap;
    import map.cell.Cell;
    import map.cell.type.ObstacleCell;
    import map.cell.type.direction.Direction;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class Laser
    {
        private static const LASER_WIDTH: int = 4;

        private var _gameMap: GameMap;
        private var _x: Number;
        private var _y: Number;
        private var _direction: Direction;

        private var _targets: Array;
        private var _length: Number;
        private var _fire: Shape;

        public function Laser(x: Number, y: Number, direction: Direction, gameMap: GameMap)
        {
            _x = x;
            _y = y;
            _direction = direction;
            _gameMap = gameMap;
        }

        public function fire(): void
        {
            var dx: int = GameMap.scaleCoordinate(_direction.x);
            var dy: int = GameMap.scaleCoordinate(_direction.y);

            var currentX: Number = _x;
            var currentY: Number = _y;

            _targets = [];
            _length = Cell.SIZE;

            var inTheWalls: Boolean = !emptyCellForFire(_gameMap.findCell(currentX, currentY));
            if (inTheWalls) {
                return;
            }

            var cell: Cell = _gameMap.findCell(currentX + dx, currentY + dy);
            while (emptyCellForFire(cell)) {
                _length += Cell.SIZE;
                currentX += dx;
                currentY += dy;
                cell = _gameMap.findCell(currentX + dx, currentY + dy);
            }

            damageTarget();
        }

        public function clear(): void
        {
            if (_fire == null || _gameMap == null) {
                return;
            }

            _gameMap.removeChild(_fire);
            _fire = null;
        }

        public function draw(): DisplayObject
        {
            var fireWidth: Number = _length * _direction.x;
            var fireHeight: Number = _length * _direction.y;

            var fireX: Number = _x;
            var fireY: Number = _y;

            var isLeftDirection: Boolean = fireWidth < 0;
            if (isLeftDirection) {
                fireX += fireWidth + Cell.SIZE;
                fireWidth = -fireWidth;
            }

            var isHorizontal: Boolean = fireWidth == 0;
            if (isHorizontal) {
                fireWidth = LASER_WIDTH;
                fireX += Cell.SIZE / 2 - LASER_WIDTH / 2;
            }

            var idUpDirection: Boolean = fireHeight < 0;
            if (idUpDirection) {
                fireY += fireHeight + Cell.SIZE;
                fireHeight = -fireHeight;
            }

            var isVertical: Boolean = fireHeight == 0;
            if (isVertical) {
                fireHeight = LASER_WIDTH;
                fireY += Cell.SIZE / 2 - LASER_WIDTH / 2;
            }

            _fire = new Shape;
            _fire.graphics.beginFill(0xFF0000);
            _fire.graphics.drawRect(fireX, fireY, fireWidth, fireHeight);
            _fire.graphics.endFill();
            _gameMap.addChild(_fire);

            return _fire;
        }

        private function emptyCellForFire(cell: Cell): Boolean
        {
            var correctCell: Boolean = cell != null;
            var notObstacle: Boolean = !isObstacle(cell as ObstacleCell, _direction);
            return correctCell && notObstacle;
        }

        private function isObstacle(obstacleCell: ObstacleCell, direction: Direction): Boolean
        {
            if (obstacleCell == null) {
                return false;
            }

            return !obstacleCell.canMove(direction) || !obstacleCell.canMove(direction.reverse());
        }

        private function damageTarget(): void
        {
            for each (var target: Cell in _targets) {
                target.dispatchEvent(new GameEvent(GameEvent.ON_DAMAGE));
            }
        }
    }
}

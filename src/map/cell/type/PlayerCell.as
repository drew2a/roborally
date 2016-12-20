package map.cell.type
{

    import flash.display.Bitmap;

    import game.Laser;

    import map.GameMap;
    import map.cell.Cell;
    import map.cell.type.direction.Direction;
    import map.cell.type.direction.DirectionFactory;
    import map.cell.type.direction.DirectionInformation;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class PlayerCell extends Cell
    {
        public static const NAME: String = "player";
        private static const MAX_DIRECTION: int = 3;
        public static const MAX_HEALTH: int = 10;
        private var _playerL: Bitmap = new EmbedClasses.playerL;
        private var _playerU: Bitmap = new EmbedClasses.playerU;
        private var _playerR: Bitmap = new EmbedClasses.playerR;
        private var _playerD: Bitmap = new EmbedClasses.playerD;
        private var _playerDirection: int = 0;
        private var _directions: Array = [];
        private var _laser: Laser;
        private var _health: int = MAX_HEALTH;

        public function PlayerCell(name: String)
        {
            super(name);
        }

        override protected function init(): void
        {
            super.init();

            addChild(_playerL);
            addChild(_playerU);
            addChild(_playerR);
            addChild(_playerD);

            _directions.push(new DirectionInformation(_playerU, DirectionFactory.create(DirectionFactory.UP)));
            _directions.push(new DirectionInformation(_playerL, DirectionFactory.create(DirectionFactory.LEFT)));
            _directions.push(new DirectionInformation(_playerD, DirectionFactory.create(DirectionFactory.DOWN)));
            _directions.push(new DirectionInformation(_playerR, DirectionFactory.create(DirectionFactory.RIGHT)));

            gameMap.post.addEventListener(GameEvent.ON_START_FIRE, onFireStart);
            gameMap.post.addEventListener(GameEvent.ON_FINISH_FIRE, onFireFinish);

            gameMap.post.addEventListener(GameEvent.ON_DAMAGE, onDamage);
            gameMap.post.addEventListener(GameEvent.ON_PLAYER_PUSH, onPush);
            hideAll();
            direct(0)
        }

        public function backward(): void
        {
            var directionInformation: DirectionInformation = _directions[_playerDirection] as DirectionInformation;
            if (directionInformation == null || directionInformation.direction == null) {
                return;
            }

            moveBy(directionInformation.direction.reverse());
        }

        public function forward(): void
        {
            var directionInformation: DirectionInformation = _directions[_playerDirection] as DirectionInformation;
            if (directionInformation == null) {
                return;
            }
            moveBy(directionInformation.direction);
        }

        public function direct(direction: int): void
        {
            if (direction > MAX_DIRECTION) {
                direction = 0;
            }

            if (direction < 0) {
                direction = MAX_DIRECTION;
            }

            var directionInformation: DirectionInformation = _directions[direction] as DirectionInformation;
            if (directionInformation == null) {
                return;
            }

            hideAll();
            directionInformation.bitmap.visible = true;
            _playerDirection = direction;
        }

        public function moveBy(direction: Direction): void
        {
            if (direction == null || !canMove(direction)) {
                return;
            }

            var nextX: Number = x + GameMap.scaleCoordinate(direction.x);
            var nextY: Number = y + GameMap.scaleCoordinate(direction.y);

            gameMap.post.dispatchEvent(new GameEvent(GameEvent.ON_PLAYER_PUSH, {
                x: nextX,
                y: nextY,
                direction: direction
            }));

            x = nextX;
            y = nextY;
        }

        public function left(): void
        {
            direct(_playerDirection + 1)
        }

        public function right(): void
        {
            direct(_playerDirection - 1)
        }

        private function canMove(direction: Direction): Boolean
        {
            var nextX: int = x + GameMap.scaleCoordinate(direction.x);
            var nextY: int = y + GameMap.scaleCoordinate(direction.y);

            var currentCell: Cell = gameMap.findCell(x, y);
            var nextCell: Cell = gameMap.findCell(nextX, nextY);

            return canMoveThrowCell(currentCell, direction) && canMoveThrowCell(nextCell, direction.reverse());
        }

        private function canMoveThrowCell(cell: Cell, direction: Direction)
        {
            if (cell == null) {
                return false;
            }

            var obstacleCell: ObstacleCell = cell as ObstacleCell;
            if (obstacleCell == null) {
                return true;
            }

            return obstacleCell.canMove(direction);
        }

        private function hideAll(): void
        {
            _playerL.visible = false;
            _playerU.visible = false;
            _playerR.visible = false;
            _playerD.visible = false;
        }

        private function onDie(): void
        {

        }

        private function onPush(event: GameEvent): void
        {
            if (event.object == null) {
                return;
            }

            var isMe: Boolean = event.object.x == x && event.object.y == y;
            if (isMe) {
                moveBy(event.object.direction);
            }
        }

        private function onDamage(event: GameEvent): void
        {
            if (dead) {
                return;
            }

            _health--;
            gameMap.post.dispatchEvent(new GameEvent(GameEvent.ON_DAMAGE, this));

            if (dead) {
                onDie();
            }
        }

        private function onFireFinish(event: GameEvent): void
        {
            if (_laser == null) {
                return;
            }

            _laser.clear();
            _laser = null;

        }

        private function onFireStart(event: GameEvent): void
        {
            if (dead) {
                return;
            }

            _laser = new Laser(x, y, _directions[_playerDirection].direction, gameMap);
            _laser.fire();
            _laser.draw();
        }

        public function get health(): int
        {
            return _health;
        }

        public function get dead(): Boolean
        {
            return _health <= 0;
        }
    }
}

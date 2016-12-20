package map.cell.type
{

    import flash.display.Bitmap;

    import game.Laser;

    import map.cell.Cell;
    import map.cell.type.direction.Direction;
    import map.cell.type.direction.DirectionFactory;
    import map.cell.type.direction.DirectionInformation;

    import postOffice.GameEvent;

    /**
     * @author Drew
     */
    public class LaserCell extends Cell
    {
        public static const NAME: String = "laser";
        private static const OFFSET: int = 6;
        private var _directionInformation: DirectionInformation;
        private var _laser: Laser;

        public function LaserCell(name: String)
        {
            super(name);
        }

        override protected function init(): void
        {
            super.init();
            addChild(new EmbedClasses.cell);
            addChild(_directionInformation.bitmap);

            gameMap.post.addEventListener(GameEvent.ON_START_FIRE, onFireStart);
            gameMap.post.addEventListener(GameEvent.ON_FINISH_FIRE, onFireFinish);
        }

        override public function load(cellConfig: Object): void
        {
            super.load(cellConfig);
            _directionInformation = createDirection(cellConfig.direction);
        }

        private function createDirection(directionType: String): DirectionInformation
        {
            var direction: Direction = DirectionFactory.create(directionType);

            switch (directionType) {
                case DirectionFactory.RIGHT:
                    var laserL: Bitmap = new EmbedClasses.laserL;
                    laserL.y = OFFSET;
                    return new DirectionInformation(laserL, direction);
                case DirectionFactory.LEFT:
                    var laserR: Bitmap = new EmbedClasses.laserR;
                    laserR.x = SIZE - laserR.width;
                    laserR.y = OFFSET;
                    return new DirectionInformation(laserR, direction);
                case DirectionFactory.DOWN:
                    var laserU: Bitmap = new EmbedClasses.laserU;
                    laserU.x = OFFSET;
                    return new DirectionInformation(laserU, direction);
                case DirectionFactory.UP:
                    var laserD: Bitmap = new EmbedClasses.laserD;
                    laserD.x = OFFSET;
                    laserD.y = SIZE - laserD.height;
                    return new DirectionInformation(laserD, direction);
            }
            return new DirectionInformation(new EmbedClasses.laserD, direction);
        }

        public function onFireStart(event: GameEvent): void
        {
            _laser = new Laser(x, y, _directionInformation.direction, gameMap);
            _laser.fire();
            _laser.draw();
        }

        public function onFireFinish(event: GameEvent): void
        {
            if (_laser == null) {
                return;
            }

            _laser.clear();
            _laser = null;
        }
    }
}

package map.cell.type
{

    import flash.display.Bitmap;

    import map.cell.Cell;
    import map.cell.type.direction.Direction;
    import map.cell.type.direction.DirectionFactory;

    /**
     * @author Drew
     */
    public class ObstacleCell extends Cell
    {
        public static const NAME: String = "obstacle";
        private static const OFFSET: int = 6;
        private var _directions: Array = [];
        private var _bitmaps: Array = [];

        public function ObstacleCell(name: String)
        {
            super(name);
        }

        private static function createBitmap(direction: String): Bitmap
        {
            var bitmap: Bitmap = null;
            switch (direction) {
                case DirectionFactory.LEFT:
                    bitmap = new EmbedClasses.wallV;
                    bitmap.y = OFFSET;
                    break;
                case DirectionFactory.RIGHT:
                    bitmap = new EmbedClasses.wallV;
                    bitmap.x = SIZE - bitmap.width;
                    bitmap.y = OFFSET;
                    break;
                case DirectionFactory.UP:
                    bitmap = new EmbedClasses.wallH;
                    bitmap.x = OFFSET;
                    break;
                case DirectionFactory.DOWN:
                    bitmap = new EmbedClasses.wallH;
                    bitmap.x = OFFSET;
                    bitmap.y = SIZE - bitmap.height;
                    break;
            }

            return bitmap;
        }

        override protected function init(): void
        {
            super.init();
            addChild(new EmbedClasses.cell);
            for each(var bitmap: Bitmap in _bitmaps) {
                addChild(bitmap);
            }
        }

        override public function load(cellConfig: Object): void
        {
            super.load(cellConfig);

            for each(var direction: String in cellConfig.directions) {
                _directions.push(DirectionFactory.create(direction));
                _bitmaps.push(createBitmap(direction));
            }
        }

        public function canMove(direction: Direction): Boolean
        {
            for each (var direct: Direction in _directions) {
                if (direct.equal(direction)) {
                    return false
                }
            }

            return true;
        }
    }
}

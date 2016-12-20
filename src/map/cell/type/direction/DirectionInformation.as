package map.cell.type.direction
{

    import flash.display.Bitmap;

    /**
     * @author Drew
     */
    public class DirectionInformation
    {
        private var _bitmap: Bitmap;
        private var _direction: Direction;

        public function DirectionInformation(bitmap: Bitmap, direction: Direction)
        {
            _bitmap = bitmap;
            _direction = direction;
        }

        public function get bitmap(): Bitmap
        {
            return _bitmap;
        }

        public function get direction(): Direction
        {
            return _direction;
        }
    }
}

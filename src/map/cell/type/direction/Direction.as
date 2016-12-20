package map.cell.type.direction
{


    /**
     * @author Drew
     */
    public class Direction
    {
        private var _x: int;
        private var _y: int;

        public function Direction(x: int, y: int)
        {
            _x = x;
            _y = y;
        }

        public function reverse(): Direction
        {
            return new Direction(-_x, -_y);
        }

        public function equal(direction: Direction): Boolean
        {
            if (direction == null) {
                return false;
            }

            return x == direction.x && y == direction.y;
        }

        public function get x(): int
        {
            return _x;
        }

        public function get y(): int
        {
            return _y;
        }
    }
}

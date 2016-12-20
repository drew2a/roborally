package map.cell.type.direction
{


    /**
     * @author Drew
     */
    public class DirectionFactory
    {
        public static const UP: String = "up";
        public static const LEFT: String = "left";
        public static const DOWN: String = "down";
        public static const RIGHT: String = "right";

        public static function create(name: String): Direction
        {
            switch (name) {
                case DirectionFactory.LEFT:
                    return new Direction(-1, 0);
                case DirectionFactory.RIGHT:
                    return new Direction(1, 0);
                case DirectionFactory.UP:
                    return new Direction(0, -1);
                case DirectionFactory.DOWN:
                    return new Direction(0, 1);
            }
            return null;
        }
    }
}
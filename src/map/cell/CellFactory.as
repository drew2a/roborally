package map.cell
{

    import map.cell.type.EmptyCell;
    import map.cell.type.LaserCell;
    import map.cell.type.ObstacleCell;
    import map.cell.type.PlayerCell;
    import map.cell.type.TransporterCell;
    import map.cell.type.TurnerCell;

    /**
     * @author Drew
     */
    public class CellFactory
    {
        private static var _cells: Object = {};
        {
            _cells[EmptyCell.NAME] = EmptyCell;
            _cells[ObstacleCell.NAME] = ObstacleCell;
            _cells[PlayerCell.NAME] = PlayerCell;
            _cells[TurnerCell.NAME] = TurnerCell;
            _cells[TransporterCell.NAME] = TransporterCell;
            _cells[LaserCell.NAME] = LaserCell;
        }

        public static function create(name: String): Cell
        {
            return new _cells[name](name);
        }
    }
}

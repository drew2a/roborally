package map.cell.type
{

    import map.cell.Cell;

    /**
     * @author Drew
     */
    public class TurnerCell extends Cell
    {
        public static const NAME: String = "turner";
        private var _CW: Boolean = false;

        public function TurnerCell(name: String)
        {
            super(name);
        }

        override protected function init(): void
        {
            super.init();
            addChild(new EmbedClasses.cell);

            if (_CW) {
                addChild(new EmbedClasses.turnRight);
                return;
            }

            addChild(new EmbedClasses.turnLeft);
        }

        override public function load(cellConfig: Object): void
        {
            super.load(cellConfig);
            _CW = cellConfig.CW;
        }

        public function get CW(): Boolean
        {
            return _CW;
        }
    }
}

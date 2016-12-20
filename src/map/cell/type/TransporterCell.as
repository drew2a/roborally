package map.cell.type
{

    import map.cell.Cell;
    import map.cell.type.direction.Direction;
    import map.cell.type.direction.DirectionFactory;
    import map.cell.type.direction.DirectionInformation;

    /**
     * @author Drew
     */
    public class TransporterCell extends Cell
    {
        public static const NAME: String = "transporter";
        private var _directionInformation: DirectionInformation;

        public function TransporterCell(name: String)
        {
            super(name);
        }

        override protected function init(): void
        {
            super.init();
            addChild(new EmbedClasses.cell);
            addChild(_directionInformation.bitmap);
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
                case DirectionFactory.LEFT:
                    return new DirectionInformation(new EmbedClasses.transporterL, direction);
                case DirectionFactory.RIGHT:
                    return new DirectionInformation(new EmbedClasses.transporterR, direction);
                case DirectionFactory.UP:
                    return new DirectionInformation(new EmbedClasses.transporterU, direction);
                case DirectionFactory.DOWN:
                    return new DirectionInformation(new EmbedClasses.transporterD, direction);
            }

            return new DirectionInformation(new EmbedClasses.transporterD, direction);
        }

        public function get directionInformation(): DirectionInformation
        {
            return _directionInformation;
        }
    }
}
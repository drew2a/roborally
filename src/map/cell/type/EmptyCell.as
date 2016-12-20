package map.cell.type
{

    import map.cell.Cell;

    /**
     * @author Drew
     */
    public class EmptyCell extends Cell
    {
        public static const NAME: String = "empty";

        public function EmptyCell(name: String)
        {
            super(name);
        }

        override protected function init(): void
        {
            super.init();
            addChild(new EmbedClasses.cell);
        }
    }
}

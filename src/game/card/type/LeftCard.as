package game.card.type
{

    import action.type.LeftAction;

    import game.card.Card;

    /**
     * @author Drew
     */
    public class LeftCard extends Card
    {
        public static const NAME: String = "left";

        public function LeftCard(name: String)
        {
            super(name, new LeftAction(this));
            addChild(new EmbedClasses.cell);
            addChild(new EmbedClasses.left);
        }
    }
}

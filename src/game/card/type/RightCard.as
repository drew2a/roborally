package game.card.type
{

    import action.type.RightAction;

    import game.card.Card;

    /**
     * @author Drew
     */
    public class RightCard extends Card
    {
        public static const NAME: String = "right";

        public function RightCard(name: String)
        {
            super(name, new RightAction(this));
            addChild(new EmbedClasses.cell);
            addChild(new EmbedClasses.right);
        }
    }
}

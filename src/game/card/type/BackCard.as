package game.card.type
{

    import action.type.BackAction;

    import game.card.Card;

    /**
     * @author Drew
     */
    public class BackCard extends Card
    {
        public static const NAME: String = "back";

        public function BackCard(name: String)
        {
            super(name, new BackAction(this));
            addChild(new EmbedClasses.cell);
            addChild(new EmbedClasses.backArrow);
        }
    }
}

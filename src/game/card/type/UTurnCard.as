package game.card.type
{

    import action.type.UTurnAction;

    import game.card.Card;

    /**
     * @author Drew
     */
    public class UTurnCard extends Card
    {
        public static const NAME: String = "uturn";

        public function UTurnCard(name: String)
        {
            super(name, new UTurnAction(this));
            addChild(new EmbedClasses.cell);
            addChild(new EmbedClasses.uturn);
        }
    }
}

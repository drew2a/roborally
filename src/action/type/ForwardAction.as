package action.type
{

    import action.Action;

    import game.card.Card;
    import game.card.type.ForwardCard;

    import map.GameMap;

    /**
     * @author Drew
     */
    public class ForwardAction extends Action
    {
        public function ForwardAction(card: Card)
        {
            super(card);
        }

        override public function start(gameMap: GameMap): void
        {
            super.start(gameMap);
            var forwardCard: ForwardCard = card as ForwardCard;
            if (forwardCard == null) {
                return;
            }

            for (var i: int = 0; i < forwardCard.steps; i++) {
                card.player.cell.forward();
            }
        }
    }
}

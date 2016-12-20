package action.type
{

    import action.Action;

    import game.card.Card;

    import map.GameMap;

    /**
     * @author Drew
     */
    public class LeftAction extends Action
    {
        public function LeftAction(card: Card)
        {
            super(card);
        }

        override public function start(gameMap: GameMap): void
        {
            super.start(gameMap);
            card.player.cell.left();
        }
    }
}

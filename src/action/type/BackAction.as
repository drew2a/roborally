package action.type
{

    import action.Action;

    import game.card.Card;
    import game.player.Player;

    import map.GameMap;

    /**
     * @author Drew
     */
    public class BackAction extends Action
    {
        public function BackAction(card: Card)
        {
            super(card);
        }

        override public function start(gameMap: GameMap): void
        {
            super.start(gameMap);

            card.player.cell.backward();
        }
    }
}

package action.type
{

    import action.Action;

    import game.card.Card;
    import game.player.Player;

    import map.GameMap;
    import map.cell.type.PlayerCell;

    /**
     * @author Drew
     */
    public class UTurnAction extends Action
    {
        public function UTurnAction(card: Card)
        {
            super(card);
        }

        override public function start(gameMap: GameMap): void
        {
            super.start(gameMap);

            var playerCell: PlayerCell = card.player.cell;
            playerCell.left();
            playerCell.left();
        }
    }
}

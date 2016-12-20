package game.player
{


    /**
     * @author Drew
     */
    public class PlayerFactory
    {
        private static var _players: Object = {};
        {
            _players[Human.NAME] = Human;
            _players[Bot.NAME] = Bot;
        }

        public static function create(type: String): Player
        {
            var player: Player = new _players[type]();
            player.playerType = type;
            return player;
        }
    }
}

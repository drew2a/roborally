package game
{

    import flash.events.EventDispatcher;

    import game.player.Player;
    import game.player.PlayerFactory;
    import game.round.GameRound;

    import map.GameMap;

    /**
     * @author Drew
     */
    public class GameModel
    {
        private var _round: GameRound;
        private var _players: Array;
        private var _map: GameMap;
        private var _post: EventDispatcher;

        public function GameModel(post: EventDispatcher)
        {
            _post = post;
        }

        public function loadMap(mapJson: String): void
        {
            _map = new GameMap(_post);
            _map.load(mapJson);
        }

        public function loadPlayers(mapJson: String): void
        {
            _players = [];
            var mapConfig: Object = JSON.parse(mapJson);
            for each(var playerObject: Object in mapConfig.players) {
                var player: Player = PlayerFactory.create(playerObject.type);
                player.post = _post;
                player.gameModel = this;
                player.load(playerObject);
                player.init();
                _players.push(player);
            }
        }

        public function get round(): GameRound
        {
            return _round;
        }

        public function set round(value: GameRound): void
        {
            _round = value;
        }

        public function get players(): Array
        {
            return _players;
        }

        public function set players(value: Array): void
        {
            _players = value;
        }

        public function get map(): GameMap
        {
            return _map;
        }

        public function set map(value: GameMap): void
        {
            _map = value;
        }
    }
}

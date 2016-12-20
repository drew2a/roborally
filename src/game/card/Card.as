package game.card
{

    import action.Action;

    import flash.events.MouseEvent;

    import game.player.Player;

    import map.GameMap;

    import stack.Stack;

    import tool.DisplayUtil;

    import ui.StageObject;

    /**
     * @author Drew
     */
    public class Card extends StageObject
    {
        public static const SIZE: int = 50;
        private var _name: String;
        private var _target: Stack;
        private var _owner: Stack;
        private var _enable: Boolean = true;
        private var _action: Action;
        private var _player: Player;
        private var _priority: int;

        public function Card(name: String, action: Action)
        {
            _name = name;
            _action = action;
        }

        override protected function init(): void
        {
            super.init();

            addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            addEventListener(MouseEvent.CLICK, onClick);
        }

        public function select(): void
        {
            DisplayUtil.addStroke(this);
        }

        public function doAction(map: GameMap): void
        {
            if (_action == null) {
                return;
            }

            _action.start(map);
        }

        private function switchOwnerAndTarget(): void
        {
            var previousOwner: Stack = _owner;
            _owner = _target;
            _target = previousOwner;
        }

        private function onClick(event: MouseEvent): void
        {
            if (!_enable || _target == null || _owner == null) {
                return;
            }

            if (!_target.canAdd()) {
                return;
            }

            _owner.remove(this);
            _target.add(this);

            switchOwnerAndTarget();
        }

        private function onMouseOver(event: MouseEvent): void
        {
            if (!_enable) {
                return;
            }

            select();
        }

        private function onMouseOut(event: MouseEvent): void
        {
            if (!_enable) {
                return;
            }

            DisplayUtil.removeStroke(this);
        }

        public function get owner(): Stack
        {
            return _owner;
        }

        public function set owner(value: Stack): void
        {
            _owner = value;
        }

        public function get target(): Stack
        {
            return _target;
        }

        public function set target(value: Stack): void
        {
            _target = value;
        }

        public function get enable(): Boolean
        {
            return _enable;
        }

        public function set enable(value: Boolean): void
        {
            _enable = value;
        }

        public function get player(): Player
        {
            return _player;
        }

        public function set player(value: Player): void
        {
            _player = value;
        }

        public function get priority(): int
        {
            return _priority;
        }

        public function set priority(priority: int): void
        {
            _priority = priority;
        }
    }
}

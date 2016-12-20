package postOffice
{

    import flash.events.Event;

    /**
     * @author Drew
     */
    public class GameEvent extends Event
    {
        public static const ON_GAME_START: String = "onGameStart";
        public static const ON_CREATE_INCOMING_STACK: String = "onCreateIncomingStack";
        public static const ON_STACK_COMPLETE: String = "onStackComplete";
        public static const ON_STACK_NOT_COMPLETE: String = "onStackNotComplete";
        public static const ON_HUMAN_PLAYER_READY: String = "onHumanPlayerReady";
        public static const ON_ROUND_START: String = "onRoundStart";
        public static const ON_USE_STACK_ITEM: String = "onUseStackItem";
        public static const ON_ROUND_FINISH: String = "onRoundFinish";
        public static const ON_STEP_START: String = "onStepStart";

        public static const ON_MOVE_STEP_START: String = "onMoveStepStart";
        public static const ON_TRANSPORTERS_STEP_START: String = "onTranspotersStepStart";
        public static const ON_TURNERS_STEP_START: String = "onTurnersStepStart";
        public static const ON_LASER_STEP_START: String = "onLaserStepStart";

        public static const ON_START_FIRE: String = "onStartFire";
        public static const ON_FINISH_FIRE: String = "onEndFire";
        public static const ON_DAMAGE: String = "onDamage";

        public static const ON_STEP_FINISH: String = "onStepFinish";
        public static const ON_POWER_UP: String = "onPowerUp";
        public static const ON_PLAYER_READY: String = "onPlayerReady";
        public static const ON_PLAYER_PUSH: String = "onPlayerPush";
        private var _object: Object;

        public function GameEvent(type: String, object: Object = null, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);
            _object = object;
        }

        public function get object(): Object
        {
            return _object;
        }
    }
}

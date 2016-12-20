package tool
{

    /**
     * @author Drew
     */
    public class GameMath
    {
        public static function randomInt(low: int, hi: int): int
        {
            return Math.round(random(low, hi));
        }

        public static function random(low: Number, hi: Number): Number
        {
            var random: Number = Math.random();
            var scaledRandom: Number = random * (hi - low);

            return low + scaledRandom;
        }

    }
}

package tool
{

    import flash.utils.ByteArray;

    /**
     * @author Drew
     */
    public class ObjectUtil
    {
        public static function clone(source: Object): *
        {
            var myBA: ByteArray = new ByteArray();
            myBA.writeObject(source);
            myBA.position = 0;
            return (myBA.readObject());
        }
    }
}

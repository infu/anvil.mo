import Time "mo:base/Time";
import Cluster  "../type/Cluster";


module {

    public class Anvil()
    {
        let TIME_BETWEEN_UPDATES = 3600000000000; // 1 hour

        public var conf : Cluster.Config = Cluster.Config.default();
        public var oracle : Cluster.Oracle = Cluster.Oracle.default();
        
        var lastUpdate : Time.Time = 0; 

        public func needsUpdate() : Bool {
            Time.now() > (lastUpdate + TIME_BETWEEN_UPDATES);
        };

        public func update() : async () {
            let (a, b) = await Cluster.router(conf).settings_get();
            conf := a;
            oracle := b;
            lastUpdate := Time.now() + TIME_BETWEEN_UPDATES;
        };

    }

}

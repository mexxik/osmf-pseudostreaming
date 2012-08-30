package org.strym.osmf.plugins.pseudostreaming {
import flash.net.NetConnection;
import flash.net.NetStream;

import org.osmf.media.URLResource;
import org.osmf.net.NetConnectionFactoryBase;
import org.osmf.net.NetLoader;

public class PseudostreamingNetLoader extends NetLoader {
    private var _netStream:NetStream;

    public function PseudostreamingNetLoader(connectionFactory:NetConnectionFactoryBase) {
        super(connectionFactory);
    }

    protected override function createNetStream(connection:NetConnection, resource:URLResource):NetStream {
        _netStream = new NetStream(connection);

        return _netStream;
    }

    public function get netStream():NetStream {
        return _netStream;
    }
}
}

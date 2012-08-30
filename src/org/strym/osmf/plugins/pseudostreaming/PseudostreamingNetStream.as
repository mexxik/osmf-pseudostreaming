package org.strym.osmf.plugins.pseudostreaming {
import flash.net.NetConnection;
import flash.net.NetStream;

public class PseudostreamingNetStream extends NetStream {
    public function PseudostreamingNetStream(connection:NetConnection) {
        super(connection);
    }
}
}

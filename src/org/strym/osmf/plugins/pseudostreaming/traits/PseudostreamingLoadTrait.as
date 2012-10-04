/**
 * Created with IntelliJ IDEA.
 * User: mexxik
 * Date: 10/2/12
 * Time: 5:10 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.osmf.plugins.pseudostreaming.traits {
import org.osmf.traits.LoadTrait;
import flash.events.NetStatusEvent;
import flash.net.NetConnection;
import flash.net.NetStream;

import org.osmf.events.LoadEvent;
import org.osmf.media.MediaResourceBase;
import org.osmf.traits.LoadState;
import org.osmf.traits.LoadTrait;
import org.osmf.traits.LoaderBase;
import org.osmf.net.NetConnectionFactory;

public class PseudostreamingLoadTrait extends LoadTrait {
    public function PseudostreamingLoadTrait(loader:LoaderBase, resource:MediaResourceBase)
    {
        super(loader, resource);
    }

    public function get connection():NetConnection
    {
        return _connection;
    }

    public function set connection(value:NetConnection):void
    {
        _connection = value;
    }

    public function get netConnectionFactory():NetConnectionFactory
    {
        return _netConnectionFactory;
    }

    public function set netConnectionFactory(value:NetConnectionFactory):void
    {
        _netConnectionFactory = value;
    }

    public function get netStream():NetStream
    {
        return _netStream;
    }

    public function set netStream(value:NetStream):void
    {
        _netStream = value;
    }

    public function get shareable():Boolean
    {
        return _shareable;
    }

    public function set shareable(value:Boolean):void
    {
        _shareable = value;
    }

    override protected function loadStateChangeStart(newState:String):void
    {
        if (newState == LoadState.READY)
        {
            if (	!isStreamingResource
                    && (  netStream.bytesTotal <= 0
                    || netStream.bytesTotal == uint.MAX_VALUE
                    )
                    )
            {
                netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
            }
        }
        else if (newState == LoadState.UNINITIALIZED)
        {
            netStream = null;
        }
    }

    override public function get bytesLoaded():Number
    {
        return isStreamingResource ? NaN : (netStream != null ? netStream.bytesLoaded : NaN);
    }

    override public function get bytesTotal():Number
    {
        return isStreamingResource ? NaN : (netStream != null ? netStream.bytesTotal : NaN);
    }

    private function onNetStatus(event:NetStatusEvent):void
    {
        if (netStream.bytesTotal > 0)
        {
            dispatchEvent
                    ( new LoadEvent
                            ( LoadEvent.BYTES_TOTAL_CHANGE
                                    , false
                                    , false
                                    , null
                                    , netStream.bytesTotal
                            )
                    );

            netStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
        }
    }

    private var _connection:NetConnection;
    private var _netConnectionFactory:NetConnectionFactory;

    private var _shareable:Boolean;
    private var isStreamingResource:Boolean;
    private var _netStream:NetStream;
}
}

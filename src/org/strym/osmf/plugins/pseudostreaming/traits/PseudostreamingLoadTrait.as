/**
 * Created with IntelliJ IDEA.
 * User: mexxik
 * Date: 10/2/12
 * Time: 5:10 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.osmf.plugins.pseudostreaming.traits {
import flash.errors.IllegalOperationError;

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
import org.osmf.utils.OSMFStrings;

import org.osmf.net.NetStreamLoadTrait;

public class PseudostreamingLoadTrait extends NetStreamLoadTrait {

    public function PseudostreamingLoadTrait(loader:LoaderBase, resource:MediaResourceBase)
    {
        super(loader, resource);
    }


}
}

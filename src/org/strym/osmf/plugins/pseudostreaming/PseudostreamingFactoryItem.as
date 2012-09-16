package org.strym.osmf.plugins.pseudostreaming {
import org.osmf.media.MediaElement;
import org.osmf.media.MediaFactoryItem;
import org.osmf.media.MediaResourceBase;
import org.osmf.media.URLResource;
import org.osmf.net.NetConnectionFactory;

public class PseudostreamingFactoryItem extends MediaFactoryItem {
    public function PseudostreamingFactoryItem() {
        super(  "org.strym.osmf.plugins.pseudostreaming.PseudostreamingFactoryItem",
                canHandleResource,
                createMediaElement);
    }

    private function canHandleResource(resource:MediaResourceBase):Boolean {
        var urlResource:URLResource = resource as URLResource;

        return urlResource.url.indexOf("http://") == 0;
    }

    private function createMediaElement():MediaElement {
        var netLoader:PseudostreamingNetLoader = new PseudostreamingNetLoader(new NetConnectionFactory());
        var videoElement:PseudostreamingVideoElement = new PseudostreamingVideoElement(null, netLoader);


        return videoElement;
    }
}
}

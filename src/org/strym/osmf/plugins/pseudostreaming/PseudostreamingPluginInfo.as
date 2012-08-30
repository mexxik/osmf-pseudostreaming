package org.strym.osmf.plugins.pseudostreaming {
import org.osmf.media.MediaFactoryItem;
import org.osmf.media.PluginInfo;

public class PseudostreamingPluginInfo extends PluginInfo {
    public function PseudostreamingPluginInfo() {
        var items:Vector.<MediaFactoryItem> = new Vector.<MediaFactoryItem>();
        items.push(new PseudostreamingFactoryItem());

        super(items);
    }
}
}

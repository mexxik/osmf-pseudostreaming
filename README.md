osmf-pseudostreaming
====================

Open Source Media Framework Pseudostreaming Plugin

#Quickstart

Here is the sample Flex application that uses Spark VideoPlayer and this plugin to play pseudostreamed media.

```flex
<?xml version="1.0"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009"
               xmlns:s="library://ns.adobe.com/flex/spark"
               creationComplete="creationCompleteHandler(event)" >

    <fx:Script><![CDATA[
        import mx.events.FlexEvent;

        import org.osmf.media.MediaFactory;

        import org.osmf.media.MediaResourceBase;
        import org.osmf.media.PluginInfoResource;
        import org.osmf.net.StreamingURLResource;
        import org.strym.osmf.plugins.pseudostreaming.PseudostreamingPluginInfo;

        private static const VIDEO_URL:String = "http://pseudo01.hddn.com/vod/demo.flowplayervod/bbb-800.mp4";


        private function creationCompleteHandler(event:FlexEvent):void {
            // 1. creating a media factory
            var factory:MediaFactory = new MediaFactory();

            // 2. loading a plugin
            factory.loadPlugin(new PluginInfoResource(new PseudostreamingPluginInfo()));

            // 3. creating a resource
            var resource:MediaResourceBase = new StreamingURLResource(VIDEO_URL);

            // 4. adding the query string as a metadata
            resource.addMetadataValue("pseudostreaming_query", "?start={time}");

            // 5. creating an element
            videoPlayer.source = factory.createMediaElement(resource);
        }
        ]]></fx:Script>

    <s:VideoPlayer id="videoPlayer"
                   width="100%" height="100%" />
</s:Application>
```

## The steps:
1. Creating a media factory - we need a media factory that will create a special video elements for us.
2. Loading a plugin - loading our plugin to the media factory statically. This plugin will treat all resources that begin with "http://" as a pseudostreamed.
3. Creating a resource - in our case this should be StreamingURLResource.
4. Adding the query string as a metadata - consult the docs of your pseudostreaming server for the query it is expecting. {time} will be replaced by the new seek time.
5. Creating an element - the media factory will create a special video element with the required traits to handle pseudostreaming media.
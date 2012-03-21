import QtQuick 1.1

import QtQuick 1.1
import Widgets 1.0

Item {
    id: listItem
    width: photosListView.width; height: photosListView.height

    Component {
        id: imgDelegate

        Item {
            id: imageItem

            Image {
                id: img
                opacity:0
                anchors.centerIn: parent
                source: filePath
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                smooth: true;
                visible: albumWrapper.state === "fullscreen"
                signal ready()
                //signal loading()
                //sourceSize.width: albumWrapper.width
                //sourceSize.width: 1920
                width: ( sourceSize.width > parent.width ) ? parent.width : sourceSize.width
                height: ( sourceSize.height > parent.height ) ? parent.height : sourceSize.height
                onStatusChanged: if (img.status === Image.Ready){ ready(); opacity = 1; } //console.log("ready" + Math.random(100) +" " +source)}
                                 //else if (img.status === Image.Loading) {
                                   //  loading()
                                 //}

                //sourceSize.height: albumWrapper.height
                Behavior on opacity { NumberAnimation { duration: 500} }
            }

            Connections{
                target: photosListView;
                onCurrentIndexChanged: {
                    if ( listItem.ListView.isCurrentItem )
                    {
                        mainWindow.currentFileType = 1;
                        img.opacity = 1
                        mainWindow.updatePanel()
                    }else
                    {
                        img.opacity = 0
                    }
                }
            }
        }

    }

    Component {
        id: videoDelegate

        Item
        {
            id: videoItem

            signal ready()

            Video {
                id: video
                opacity: 0                
                anchors.fill: parent
                visible: albumWrapper.state === 'fullscreen' && video.ready

                onTicked:
                {
                    if ( playing )
                    {
                        panel.videoSlider.value = tick * 1000 / totalTime; // tick and totalTime in msec
                    }
                }

                onPlayFinished:
                {
                    //                    console.log( "video onPlayFinished slot" );
                    panel.playButtonState = 'Play'
                    panel.videoSlider.value = 0
                }
                Behavior on opacity { NumberAnimation { duration: 500} }
            }

            Connections{
                target: panel.playItemBtn;
                onButtonClick:
                {
                    if ( listItem.ListView.isCurrentItem )
                    {
                        video.play_or_pause();
                        if ( video.playing )
                            panel.playButtonState = 'Play'
                        else
                            panel.playButtonState = 'Pause'
                    }
                }
            }

            Connections{ target: panel.videoSlider; onPosChanged: video.setPosition( panel.videoSlider.value * video.totalTime / 1000 ) }
            Connections
            {
                target: albumWrapper;
                onStateChanged:
                {

                    if (albumWrapper.state === "inGrid")
                    {

                        video.pause()
                    }
                    else
                    {

                        video.play()
                    }
                }
            }
            //Connections{ target: mouseAreaGrid; onClicked: updateVideoItemState( video ) }

            Connections{
                target: photosListView;
                onCurrentIndexChanged: {
                    if ( listItem.ListView.isCurrentItem )
                    {
                        video.opacity = 1
                        video.setPlayerParent()
                        video.source = filePath
                        mainWindow.currentFileType = 2;
                        mainWindow.updatePanel()
                        if (albumWrapper.state === "fullscreen" )
                        {

                            video.play()
                        }
                        if ( video.playing )
                        {
                            panel.playButtonState = 'Play'
                        }
                        else
                            panel.playButtonState = 'Pause'
                    }
                    else
                        video.opacity = 0
                }
            }

        }
    }

    Component {
        id: txtDelegate
        Item {
            id: txtItem
            PlainText {
                id: txt
                source: filePath
                anchors.fill: parent
                preview: false
            }
            Connections{
                target: photosListView;
                onCurrentIndexChanged: {
                    if ( listItem.ListView.isCurrentItem )
                    {
                        mainWindow.currentFileType = 3;
                        mainWindow.updatePanel()
                    }
                }
            }
        }
    }

    // function for getting delegate of loader element
    function bestDelegate( t ) {

        if ( t == 1 )
            return imgDelegate;
        else if ( t == 2 )
            return videoDelegate;
        else if ( t == 3 )
            return txtDelegate;
        else
            return txtDelegate;
    }

    Loader
    {
        id: componentLoader
        anchors.fill: parent;
        sourceComponent: bestDelegate( mimeType )
        /*
        onLoaded: {
            console.log( "onLoaded(): w = " + item.width );
        }
        */
    }
}


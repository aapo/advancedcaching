import QtQuick 1.1
import com.nokia.meego 1.0
import "uiconstants.js" as UI

Page {
    id: listPage
    Header{
        text: "Geocache <b>"+currentGeocache.name+"</b>"
        id: listHeader
    }

    ListView {
        anchors.top: listHeader.bottom
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom:  parent.bottom
        model: currentGeocacheCoordinates
        id: list
        delegate: Item {
            BorderImage {
                 id: background
                 anchors.fill: parent
                 anchors.leftMargin: -16
                 anchors.rightMargin: -16
                 visible: mouseArea.pressed
                 source: "image://theme/meegotouch-list-background-pressed-center"
             }

             Row {
                 id: r
                 anchors.verticalCenter: parent.verticalCenter
                 Column {

                     Label {
                         id: mainText
                         text: model.coordinate.display_text
                         font.weight: Font.Bold
                         font.pixelSize: 26
                         width: list.width - arrow.width
                         wrapMode: Text.WordWrap
                     }

                     Label {
                         id: subText
                         text: model.coordinate.comment
                         font.weight: Font.Light
                         font.pixelSize: 22
                         color: UI.COLOR_DESCRIPTION
                         visible: text != ""
                         width: list.width - arrow.width
                         wrapMode: Text.WordWrap
                     }

                     Label {
                         id: subCoordinate
                         text: model.coordinate.name
                         font.weight: Font.Light
                         font.pixelSize: 22
                         visible: text != ""
                     }
                 }
             }

             Image {
                 id: arrow
                 source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
                 anchors.right: parent.right;
                 anchors.verticalCenter: parent.verticalCenter
             }

             MouseArea {
                 id: mouseArea
                 anchors.fill: background
                 onClicked: {
                     //listPage.openFile(page)
                     showDescription.coordinate = model.coordinate
                     showDescription.open()
                 }
             }
             height: r.height + 16
             width: parent.width
        }
    }

    QueryDialog {
        id: showDescription
        property variant coordinate: false
        anchors.centerIn: parent
        acceptButtonText: "Set as Target"
        rejectButtonText: "cancel"
        titleText: coordinate ? coordinate.name : "undefined"
        // todo: Gesamtwert berechnen
        content: [
            Column {
                Text {
                    text: showDescription.coordinate ? (showDescription.coordinate.lat + "/" + showDescription.coordinate.lon) : "undefined"
                    width: showDescription.width
                    font.weight: Font.Light
                    color: UI.COLOR_DIALOG_TEXT
                    wrapMode: Text.WordWrap
                    font.pixelSize: UI.FONT_DEFAULT
                }/*
                Text {
                    text: showDescription.coordinate.display_text || "undefined"
                    width: showDescription.width
                    font.weight: Font.Light
                    wrapMode: Text.WordWrap
                    color: UI.COLOR_DIALOG_TEXT
                    font.pixelSize: UI.FONT_SMALL
                }*/
                Text {
                    text: showDescription.coordinate ? showDescription.coordinate.comment : "undefined"
                    width: showDescription.width
                    wrapMode: Text.WordWrap
                    color: UI.COLOR_DIALOG_TEXT
                    font.pixelSize: UI.FONT_SMALL
                }
                PinchMap {
                    centerLatitude: showDescription.coordinate ? showDescription.coordinate.lat : 49
                    centerLongitude: showDescription.coordinate ? showDescription.coordinate.lon : 6
                    showTargetIndicator: true
                    showTargetAtLat: showDescription.coordinate ? showDescription.coordinate.lat : 49
                    showTargetAtLon: showDescription.coordinate ? showDescription.coordinate.lon : 6
                    zoomLevel: 13
                    width: showDescription.width
                    height: 300
                    clip: true
                }
            }

        ]
        onAccepted: {
            controller.setAsTarget(coordinate)
        }
    }
}

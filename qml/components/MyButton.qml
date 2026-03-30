import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle
{
    id:root

    width:parentWidth
    height:150
    opacity:0.3
    visible:true
    color:colorButton
    radius:15
    border.width:5
    border.color:"white"
    property url image:value
    property string text:value
    property string colorButton: value

    signal clicked()

    MouseArea
    {
        anchors.fill: root
        hoverEnabled: true
        onClicked:
        {
            console.log("MyButton/clicked")
            root.clicked()
        }
        onPressed:
        {
            root.border.color="lightgrey"
        }

        onReleased:
        {
            root.border.color="white"
        }

        onEntered:
        {
            root.border.width=8
            textButton.font.pixelSize=55
            imageButton.scale=1.2
        }

        onExited:
        {
            root.border.width=5
            textButton.font.pixelSize=50
            imageButton.scale=1
        }

    }

    Row
    {

        anchors.horizontalCenter: parent.horizontalCenter
        spacing:5

        Image
        {
            id:imageButton
            width:(root.height*1.5)
            height:(root.height*1.5)
            fillMode:Image.PreserveAspectFit
            source: root.image

        }

        Text
        {
            id:textButton

            width:50
            anchors.verticalCenter: parent.verticalCenter
            text:root.text
            color:"white"
            font.italic:true
            font.pixelSize:50

        }
    }

    PropertyAnimation
    {
        id:animOpacity
        target:root
        property: "opacity"
        to:1

        duration:2000
    }

    Component.onCompleted:
    {
        target:root
        animOpacity.running=true
    }

}







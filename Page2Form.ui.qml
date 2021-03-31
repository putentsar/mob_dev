import QtQuick 2.4
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12
import QtMultimedia 5.14 //для камеры
import QtGraphicalEffects 1.14
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.0
import QtQml 2.14
import QtWebView 1.14
import QtCharts 2.0
import QtWebSockets 1.1


Page{  //СТРАНИЦА ДЛЯ ВТОРОЙ ЛАБОРАТОРНОЙ - СЪЕМКА И ВОСПРОИЗВЕДЕНИЕ ВИДЕО


    id: page02
    header: Rectangle {
        id: page_header2
                     color: "#395693"
                     y: 0; height: 50

        Label{

            text:"ЛР2 Съемка и воспроизведение видео"
            color: "white"
            anchors.verticalCenter: page_header2.verticalCenter
            anchors.horizontalCenter: page_header2.horizontalCenter
            padding: 10
        }

        Image {
        id:facebook1
        source: "facebook.png" // loads vk.png
        width: 26
        height: 25
        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.left
        anchors.verticalCenterOffset: parent.height/2
        anchors.horizontalCenterOffset: this.width/2+10
        }
    }



    RowLayout{
        id: rowforradio
        spacing: 80
        anchors.top: parent.top
        anchors.topMargin: 20
        height: 40
        anchors.horizontalCenter: parent.horizontalCenter

        RadioButton{
            id: radio1
            checked: true
            onClicked: {
                page1.visible = true
                page2.visible = false

            }
            Label
                {
                text:  qsTr("Камера")
                font.family: "Arial"
                font.pointSize: 15
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 50
            }
        }
       RadioButton{
            id: radio2
//            text: "Фотопоток"
             Material.background: "#395693"
            onClicked: {
                page1.visible = false
                page2.visible = true
            }
            Label
                {
                text:  qsTr("Видео")
                font.family: "Arial"
                font.pointSize: 15
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 45
            }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rowforradio.bottom
        anchors.bottom: parent.bottom
        anchors.verticalCenter: parent.verticalCenter
        border.color: "#395693"


        Item{  //СТРАНИЦА С КАМЕРОЙ
            id: page1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rowforradio.bottom
            anchors.bottom: parent.bottom
            anchors.verticalCenter: parent.verticalCenter

            Camera{
                id: camera
                imageCapture{
                    onImageCaptured: {
                        photoPreview.source = preview
                    }
                }
            }

            VideoOutput{
                id: photocam
                source: camera  //показывает на экране во время записи
                anchors.left: page1.left
                anchors.right: page1.right
                anchors.top: rowforradio.bottom
                anchors.bottom: page1.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.bottomMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: photoPreview
                    height: 40
                    width: 75
                    anchors.right: parent.right

                    MouseArea {
                        anchors.fill: parent;
                        onClicked: photoPreview.width = 355, photoPreview.height = 190
                        onDoubleClicked: photoPreview.width = 75, photoPreview.height = 40
                    }
                }
            }
            RowLayout{
                id: rowforbnt
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: photocam.bottom
                anchors.bottomMargin: 50

                RoundButton{
                    id: capturebutton
                    Material.background: "#395693"
                    text: "C"
                    onClicked: camera.imageCapture.captureToLocation("C:\Users\semyo\Desktop\phot")
                }

                RoundButton {
                    id: videobutton
                    Material.background: "red"
                    text: "R"
                    onClicked:
                        if(camera.videoRecorder.StoppedState)
                            сamera.videoRecorder.stop()
                        else
                            camera.videoRecorder.record()
                }
            }
        }
    }

    Item{  //страница с просмотром видео
        id: page2
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rowforradio.bottom
        anchors.bottom: parent.bottom

        Button {
            id: btnfordialoglab2
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("<b>Файл</b>")
            width: parent.width/3

            contentItem: Text {
                text: btnfordialoglab2.text
                font.family: "Arial"
                font.pointSize: 14
                opacity: enabled ? 1.0 : 0.3
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: btnfordialoglab2.down ? "#496fbf" : "#395693"
                border.color: "#395693"
                border.width: 1
                radius: 3
            }
            onClicked: fileDialog.open()

            FileDialog {
                id: fileDialog
                folder: shortcuts.home
                nameFilters: [ "Music files (*.mp4 *.avi *.mkv *.mov)"]

            }
        }

        Rectangle{
            id: rectangleforvideo
            anchors.left: page2.left
            anchors.right: page2.right
            anchors.top: btnfordialoglab2.bottom
            anchors.bottom: page2.bottom
            anchors.leftMargin: 3
            anchors.rightMargin: 3

            color: "white"

            MediaPlayer {
                id: player
                source: if (fileDialog.fileUrl == 0) "video.avi"; else fileDialog.fileUrl
                autoPlay: true
                volume: 0
                loops: 5
            }

            VideoOutput {
                id: videoOutput
                source: player
                anchors.left: rectangleforvideo.left
                anchors.right: rectangleforvideo.right
                anchors.top: btnfordialoglab2.bottom
                anchors.bottom: sliderforvideo.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.bottomMargin: 45
                anchors.verticalCenter: rectangleforvideo.verticalCenter
            }

            Slider{
                id:sliderforvideo
                visible: true
                Material.accent: "#202124"
                value: player.position
                to: player.duration
                anchors.left: videoOutput.left
                anchors.bottom: rectangleforvideo.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: videoOutput.horizontalCenter
                onPressedChanged: {
                    player.seek(sliderforvideo.value)
                }
            }

            MouseArea {
                anchors.fill: videoOutput
                id: areaforvideolab2
                onClicked:
                    bntplayorstop.visible = true, sliderforvideo.visible = true, timerforguivideo.start()

                Button {
                    id: bntplayorstop
                    flat: true
                    anchors.horizontalCenter: areaforvideolab2.horizontalCenter
                    anchors.verticalCenter: areaforvideolab2.verticalCenter
                    icon.color: "white"
                    icon.height: 55
                    visible: false
                    icon.width: 55
                    icon.source:
                        player.playbackState == MediaPlayer.PlayingState ? "play-64.png" : "pause-64.png"
                    onClicked:
                        player.playbackState == MediaPlayer.PlayingState ? player.pause() : player.play(), timerforguivideo.restart()
                }
            }

                Timer {
                    id: timerforguivideo
                    interval: 5000; running: true; repeat: true
                    onTriggered: bntplayorstop.visible = false, sliderforvideo.visible = false
                }
        }
    }

}

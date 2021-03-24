import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.12
import QtQuick.Dialogs 1.3


ApplicationWindow {
    width: 375
     height: 667
    visible: true
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 6
        anchors.leftMargin: 0
        anchors.topMargin: -6
        currentIndex: tabBar.currentIndex

        Page {

              header: Rectangle {
                  id: page_header
                               color: "#395693"
                               y: 0; height: 50

                  Label{

                      text:"ЛР1 Ознакомление"
                      color: "white"
                      anchors.verticalCenter: page_header.verticalCenter
                      anchors.horizontalCenter: page_header.horizontalCenter
                      padding: 10
                  }

                  Image {
                  id:facebook
                  source: "facebook.png" // loads vk.png
                  width: 26
                  height: 25
                  anchors.verticalCenter: parent.top
                  anchors.horizontalCenter: parent.left
                  anchors.verticalCenterOffset: parent.height/2
                  anchors.horizontalCenterOffset: this.width/2+10
                  }



              }


GridLayout{
    anchors.leftMargin: 15
    anchors.rightMargin: 15
    anchors.fill: parent
columns: 3
rows: 4


Label{ //отступ слева
    anchors.top:parent.top //привязка сверху от родителя
    anchors.topMargin: 25
    Layout.column: 0
    Layout.row: 0
    id:status
    text:"Aдрес эл.почты:"
}

BusyIndicator{
    id:busy
    anchors.top:parent.top //привязка сверху от родителя
    anchors.topMargin: 25
anchors.right:parent.right
    Layout.column: 1
     Layout.row: 0
    Material.accent: "#395693"

}
TextField {
    id: address_txt
anchors.top:status.bottom
        Layout.column: 0
        Layout.row: 1
        Layout.fillWidth: true
        Material.accent: "#395693"
}
Label{
    anchors.top:address_txt.top //привязка сверху от родителя
    anchors.topMargin: 70
    Layout.column: 0
     Layout.row: 2
    id:ad
    text:"Включить уведомления:"
}
Switch{
    anchors.top:address_txt.top //привязка сверху от родителя
    anchors.topMargin: 55
    Layout.column: 1
     Layout.row: 2
    id: ad_switch
    Material.accent: "#395693"
    anchors.left:ad.right


}
Rectangle{ //создание панели
    id:rectangle1
    Layout.column:0
    Layout.row:3
    height: 30
    width: parent.width
    radius: 10
    anchors.left: parent.left //привязка слева от родителя
    anchors.right: parent.right //привязка справа от родителя
    anchors.top: parent.top //привязка сверху от родителя
    anchors.topMargin: 160 //отступ сверху
    color: "#395693"
    Text{
        id:textconf
        text: "Настройки интерфейса"
        font.pixelSize: 15
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
BusyIndicator{
    id:busy1
    Layout.column: 0
     Layout.row: 4
anchors.left: parent.left
anchors.leftMargin: 45
    Material.accent: "#395693"

}
DelayButton {

       id: control
     Material.accent: "#395693"
    anchors.left: parent.left //привязка слева от родителя
    Layout.column: 0
     Layout.row: 5
    checked: true

    text: qsTr("Темная\nтема")
}
DelayButton {
anchors.left: control.right
 anchors.leftMargin: 20
 Material.accent: "#395693"
    Layout.column: 1
     Layout.row: 5
    id: control1
    checked: true

    text: qsTr("Светлая\nтема")
}

Slider {
    Layout.column: 2
     Layout.row: 5
       orientation: Qt.Vertical
    anchors.right: parent.right
    id:slider
    Material.accent: "#395693"
    Image {
     anchors.bottom:parent.top
    id:sound
    source: "sound1.png" // loads vk.png
    anchors.horizontalCenter: parent.horizontalCenter

    }
}


    Button{
        id:save
            anchors.horizontalCenter: parent.horizontalCenter
        Layout.column: 0
         Layout.row: 6
        Material.accent: "#395693"        
        text:"Сохранить"

        background: Rectangle {
              implicitWidth: 100
              implicitHeight: 40
              opacity: enabled ? 1 : 0.3
              border.color: save.down ? "#20252f" : "#395693"
              border.width: 1
              radius: 4
          }
        }


}



}







        Page{  //СТРАНИЦА ДЛЯ ВТОРОЙ ЛАБОРАТОРНОЙ - СЪЕМКА И ВОСПРОИЗВЕДЕНИЕ ВИДЕО


            id: page02
            header: Rectangle {
                id: page_header2
                             color: "#395693"
                             y: 0; height: 50

                Label{

                    text:"ЛР1 Ознакомление"
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
                            Material.background: "grey"
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
                    text: qsTr("<b>Открыть видео</b>")
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
                        color: btnfordialoglab2.down ? "#6792c0" : "#5181b8"
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
                        visible: false
                        Material.accent: "#ffffff"
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
                                player.playbackState == MediaPlayer.PlayingState ? "facebook.png" : "facebook.png"
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

                            Page{
                                header: Rectangle {
                                    id: page_header3
                                                 color: "#395693"
                                                 y: 0; height: 50

                                    Label{

                                        text:"ЛР1 Ознакомление"
                                        color: "white"
                                        anchors.verticalCenter: page_header3.verticalCenter
                                        anchors.horizontalCenter: page_header3.horizontalCenter
                                        padding: 10
                                    }

                                    Image {
                                    id:facebook2
                                    source: "facebook.png" // loads vk.png
                                    width: 26
                                    height: 25
                                    anchors.verticalCenter: parent.top
                                    anchors.horizontalCenter: parent.left
                                    anchors.verticalCenterOffset: parent.height/2
                                    anchors.horizontalCenterOffset: this.width/2+10
                                    }



                                }
                            }

        }






    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
        TabButton {
            text: qsTr("Page 3")
        }
    }
}




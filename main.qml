import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4



ApplicationWindow {
    width: 460
    height: 718
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
rows: 5


Label{

    Layout.column: 0
    Layout.row: 0
    id:status
    text:"Aдрес эл.почты:"
}

TextField {
        Layout.column: 1
        Layout.row: 0
        Layout.columnSpan: 2
        Layout.alignment: Qt.AlignLeft
        Layout.fillWidth: true
        Material.accent: "#395693"
}


Label{

    Layout.column: 0
     Layout.row: 1
    id:ad
    text:"Включить уведомления:"
}
Switch{
    Layout.column: 1
     Layout.row: 1
    id:ad_switch
    Material.accent: "#395693"
    anchors.left:ad.right


}

BusyIndicator{
    Material.accent: "#395693"

}

Slider {


    Material.accent: "blue"
}


    DelayButton{
        Layout.column: 1
         Layout.row: 2
    text:""
    Material.accent: "#395693"
           id: button

    }







    Button{
        Material.accent: "#395693"
        Image {
        id:faceboo
        source: "facebook.png" // loads vk.png
        width: 26
        height: 25
        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.left
        anchors.verticalCenterOffset: parent.height/2
        anchors.horizontalCenterOffset: this.width
        }

    }




}


        }

        Page{
            GridLayout {
                   anchors.fill: parent
                   rows: 5
                   columns: 3
                   anchors.leftMargin: 15
                   anchors.rightMargin: 15

                   // Мой вариант под номером 2
                   // fio group
                   Label {
                       id: fio
                       Layout.column: 0
                       Layout.row: 0
                       text: "Введите ФИО:"
                   }

                   TextArea {
                       Layout.column: 1
                       Layout.row: 0
                       Layout.alignment: Qt.AlignLeft
                       Layout.fillWidth: true
                       Material.accent: "#3ecaff"
                   }

                   // gender group
                   Label {
                       id: gender
                       Layout.column: 0
                       Layout.row: 1
                       text: "Выберите пол:"
                   }

                   Label {
                       id: male
                       Layout.column: 0
                       Layout.row: 2
                       text: "Мужской"
                       anchors.top: gender.bottom
                       anchors.topMargin: 15
                   }

                   RadioButton {
                       Layout.column: 0
                       Layout.row: 2
                       anchors.left: male.right
                       anchors.verticalCenter: male.verticalCenter
                       Material.accent: "#3ecaff"
                   }

                   Label {
                       id: female
                       Layout.column: 0
                       Layout.row: 3
                       text: "Женский"
                       anchors.top: male.bottom
                       anchors.topMargin: 15
                   }

                   RadioButton {
                       Layout.column: 0
                       Layout.row: 3
                       anchors.left: female.right
                       anchors.verticalCenter: female.verticalCenter
                       Material.accent: "#3ecaff"
                   }

                   // dial
                   Dial {
                       id: dial
                       Layout.column: 0
                       Layout.row: 3
                       Material.accent: "#3ecaff"
                       Layout.fillWidth: true
                   }

                   // range slider
                   RangeSlider{
                       Layout.column: 0
                       Layout.row: 4
                       Layout.columnSpan: 2
                       Material.accent: "#3ecaff"
                       Layout.fillWidth: true
                   }

                   // slider
                   Rectangle {
                       id: sound
                       color: "white"
                       Layout.column: 2
                       Layout.row: 1
                       Layout.rowSpan: 3
                       width: 36
                       height: 160
                       radius: 20
                       Layout.fillHeight: true

                       Slider {
                           orientation: Qt.Vertical
                           anchors.horizontalCenter: sound.horizontalCenter
                           anchors.verticalCenter: sound.verticalCenter
                           height: sound.height - 30
                           Material.accent: "blue"
                       }
                   }


                   // check group
                   Label {
                       id: check
                       Layout.column: 0
                       Layout.columnSpan: 2
                       Layout.row: 5
                       text: "Я прочитал и согласен со всем"
                   }

                   CheckBox {
                       Layout.column: 1
                       Layout.row: 5
                       anchors.left: check.right
                       anchors.verticalCenter: check.verticalCenter
                       Material.accent: "#3ecaff"
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
    }
}

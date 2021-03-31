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
Page {
     id: page01
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

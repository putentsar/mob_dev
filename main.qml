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

ApplicationWindow {
    signal signalMakeRequestHTTP();
    property string token1: ""
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
        Page1Form{

              }
        Page2Form{  //СТРАНИЦА ДЛЯ ВТОРОЙ ЛАБОРАТОРНОЙ - СЪЕМКА И ВОСПРОИЗВЕДЕНИЕ ВИДЕО

              }
        Page3Form{  //СТРАНИЦА ДЛЯ Lab3 - HTTP-ЗАПРОСЫ

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




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


Page{  //СТРАНИЦА ДЛЯ Lab3 - HTTP-ЗАПРОСЫ
    id: page03
    Connections{
        target: WebAppController // объект - источник сигнал
        function onSignalSendToQML(pString, miniReply)
        {
            textarea.append(pString);
            textField.text = miniReply;
        }
    }
    header: Rectangle {
        id: page_header04
                     color: "#395693"
                     y: 0; height: 50

        Label{

            text:"ЛР3 HTTP-ЗАПРОСЫ"
            color: "white"
            anchors.verticalCenter: page_header04.verticalCenter
            anchors.horizontalCenter: page_header04.horizontalCenter
            padding: 10
        }

        Image {
        id:facebook04
        source: "facebook.png" // loads vk.png
        width: 26
        height: 25
        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.left
        anchors.verticalCenterOffset: parent.height/2
        anchors.horizontalCenterOffset: this.width/2+10
        }



    }


    GridLayout {
            id: siteWeather

            anchors.fill: parent
            columns: 1
            rows: 3

            Flickable {
                id: flickable

                Layout.fillHeight: true
                Layout.fillWidth: true
                TextArea.flickable: TextArea {
                    id: textarea

                    textFormat: Text.RichText/*Text.PlainText*/
                    // Text.RichText // для вывода как в веб-версии
                    wrapMode: TextArea.Wrap

                    background: Rectangle {
                        id: rectangle
                        anchors.fill: parent
                        color: "#fff"
                        BusyIndicator{
                         id:load_indicator
                           Material.accent: "#395693"
                          anchors.centerIn: parent
                        }
                    }
                    readOnly: true
                }

                ScrollBar.vertical: ScrollBar { }
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("<b>Курс доллара к рублю на сегодня</b>")
                font.pixelSize: 12
                Material.background: "#395693"
                Material.foreground: "#fff"
                onClicked: {
//                    helloImage.destroy()
                    load_indicator.visible = false;
                    textarea.clear();
                    rectangle.color = "#395693" // фон во время загрузки данных
                    textField.text = "загрузка..."

                    signalMakeRequestHTTP();
                    rectangle.color = "#fff" // фон после парсинга

                }
            }

            TextField {
                id: textField
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: TextInput.AlignHCenter
                  Material.accent: "#395693"
                color: "#395693"
                font.pixelSize: 17
                readOnly: true
            }

        }


}

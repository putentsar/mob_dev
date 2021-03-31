#include "webappcontroller.h"
#include <QNetworkRequest> // запрос
#include <QNetworkReply> // ответ
#include <QEventLoop> // (врезка обработки сигнала по месту действия)
// программа прерывается с режима ожидания, когда приходит объект и продолжает работу
#include <QDebug>
#include <QBitArray>
#include <string>
#include <iostream>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkAccessManager>
#include <string.h>
#include <QHttpMultiPart>
#include <QUrlQuery>
#include <QUrl>
#include <QtWidgets/QTableView>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlTableModel>
#include <QtSql/QSqlError>


WebAppController::WebAppController(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager();
    //database_read();

}

void WebAppController::GetNetworkValue()
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://finance.rambler.ru/currencies/USD/"));
   // qDebug() << request.url() << " | request | " << request.rawHeaderList();
    QNetworkReply * reply;
   // qDebug() << " before get() ";

    QEventLoop event_loop;
    connect(nam, &QNetworkAccessManager::finished, &event_loop, &QEventLoop::quit);
    // заместо HttpController::SlotFinished и connect(nam, &QNetworkAccessManager::finished, this, &HttpController::SlotFinished)
    reply = nam->get(request);
    //обработали reply
    event_loop.exec(); // запуск цикла ожидания - происходит обработка других сигналов, пока не наступит QEventLoop::quit

    QByteArray replyString = reply -> readAll();
    emit signalSendToQML(QString(replyString), onPageInfo(QString(replyString)));
    // qDebug() << "СЛОВО dfghjk - " << QString("dfghjk").left(3); - метод left возвращает заданное количество символов

    //qDebug() << "BEGIN - " << QString(replyString) << " - END";
    //qDebug() << reply->url() << reply->rawHeaderList() << reply->readAll();

}

QString WebAppController::onPageInfo(QString replyString) {
//    QString needString = "temp__value temp__value_with-unit\"><";
    int x = replyString.indexOf("finance-currency-plate__currency\">") + 34;
    //int y = replyString.find("<", x);
    QString tempString = replyString.mid(x+1, 7);
    QString degreesNow = tempString.mid(0, tempString.indexOf("<"));
    qDebug() << x;
 //   qDebug() << replyString;
    qDebug() << degreesNow;// погода, вывод для отдельного значения - текущая температура

    return degreesNow;
}

//QByteArray WebAppController::requestReceivingAPI(QString token)
//{
//    token.prepend("OAuth ");
//    QByteArray token_bytearray = token.toUtf8();
//    QNetworkReply * reply;
//    QEventLoop eventloop;
//    connect(nam, &QNetworkAccessManager::finished, &eventloop, &QEventLoop::quit);
//    QNetworkRequest request;
//    request.setUrl(QUrl("https://cloud-api.yandex.net:443/v1/disk/resources/files?fields=name%2C%20created%2C%20size%2C%20preview&media_type=image&offset=0&preview_crop=true&preview_size=40"));//"https://cloud-api.yandex.net/v1/disk/resources/files?fields=name%2C%20created%2C%20size%2C%20preview&media_type=image&offset=0&preview_crop=true&preview_size=40"));
//    request.setRawHeader(QByteArray("Authorization"), QByteArray(token_bytearray));
//    reply = nam->get(request);
//    eventloop.exec();
//    QByteArray replyString = reply -> readAll();
//    qDebug() << replyString << request.url().toString() <<
//                request.header(QNetworkRequest::ContentTypeHeader);


//    //parseJSON(replyString);
//   // database_write(replyString);

//    return "a";

//}

#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonArray>

class WebAppController : public QObject
{
    Q_OBJECT
public:
    explicit WebAppController(QObject *parent = nullptr);
    QNetworkAccessManager *nam;


public slots:
     void GetNetworkValue();  // метод для запроса странички с сервера

     QString onPageInfo(QString replyString);


//     QByteArray requestReceivingAPI(QString token);

 signals:
     void signalSendToQML(QString pReply, QString miniReply);
//     void signalSendToQML_2(QString currentratecostrub);
//     void signalSendToQML_3(int sizeLess1, int sizeLess2, int sizeLess3, int sizeLess4, int sizeLess5, int sizeOver5);
};

#endif // WEBAPPCONTROLLER_H






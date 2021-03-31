#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "webappcontroller.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    WebAppController WebAppController;
    app.setWindowIcon(QIcon("vk.png"));
    QQmlApplicationEngine engine;
    QQmlContext * context = engine.rootContext(); //дерево объектов в QML движке
    context->setContextProperty("WebAppController", &WebAppController);//приводим в соответствие имя сишному объекту - поместить С++ объект в область видимости QML
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    QObject * mainWindow = engine.rootObjects().first();
    QObject::connect(mainWindow, SIGNAL(signalMakeRequestHTTP()), &WebAppController, SLOT(GetNetworkValue()));
    return app.exec();
}

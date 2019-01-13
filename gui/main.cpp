#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Backend.h"
#include "ImageContainer.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Backend>("backend", 1, 0, "Backend");
    qmlRegisterType<ImageContainer>("imagecontainer", 1, 0, "ImageContainer");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

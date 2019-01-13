#include "Backend.h"
#include "ImageContainer.h"
#include <QtDebug>
#include <QQmlEngine>


Backend::Backend(QObject *parent) :
    QObject(parent)
{
}


Backend::~Backend()
{
}


QString Backend::launch(const QString &filename, QObject *imgContainer,
                        int option, const QString &txtToFind)
{
    qDebug() << "Backend::launch('filename=" << filename
             << "', option='" << option << "', txtToFind='" << txtToFind << "')";

    QString result("OCR result");
    QUrl url(filename);
    QImage image(url.toLocalFile());
    if( image.isNull() )
    {
        qDebug() << "Backend::launch(): image is NULL!";
    }
    else
    {
        // Call img2txt and get result
        ImageContainer* container = (ImageContainer*) imgContainer;
        container->setImage(image);
    }
    return result;
}

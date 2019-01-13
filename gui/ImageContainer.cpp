#include <QtDebug>
#include "ImageContainer.h"


ImageContainer::ImageContainer(QQuickItem *parent) : QQuickPaintedItem(parent)
{    
    this->m_current_image = QImage();  // Or a blank image from img folder
}


void ImageContainer::paint(QPainter *painter)
{
    QRectF bounding_rect = boundingRect();
    QImage scaled = this->m_current_image.scaledToHeight(bounding_rect.height());
    QPointF center = bounding_rect.center() - scaled.rect().center();

    if(center.x() < 0)
        center.setX(0);
    if(center.y() < 0)
        center.setY(0);

    painter->drawImage(center, scaled);
}


QImage ImageContainer::image() const
{
    return this->m_current_image;
}


void ImageContainer::setImage(const QImage &image)
{
    qDebug() << "ImageContainer::setImage()";
    this->m_current_image = image;
    update();
}

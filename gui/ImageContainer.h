#ifndef __IMAGECONTAINER_H__
#define __IMAGECONTAINER_H__

#include <QQuickPaintedItem>
#include <QQuickItem>
#include <QPainter>
#include <QImage>


class ImageContainer : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

public:
    ImageContainer(QQuickItem *parent = nullptr);
    Q_INVOKABLE void setImage(const QImage &image);
    void paint(QPainter *painter);
    QImage image() const;

signals:
    void imageChanged();

private:
    QImage m_current_image;
};

#endif  // __IMAGECONTAINER_H__

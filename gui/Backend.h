#ifndef __BACKEND_H__
#define __BACKEND_H__

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT

public:
    explicit Backend(QObject *parent = nullptr);
    ~Backend();

    Q_INVOKABLE QString launch(const QString &filename, QObject *imgContainer,
                               int option=-1, const QString &txtToFind="");

signals:

public slots:

protected:

private:
};

#endif // __BACKEND_H__

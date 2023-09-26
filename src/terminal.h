#ifndef TEST_H
#define TEST_H

#include <QObject>

class Terminal : public QObject
{
	Q_OBJECT

public:
	Q_INVOKABLE QString command(QString cmd);

private:




};

#endif

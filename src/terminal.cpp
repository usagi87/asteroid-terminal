#include <QCoreApplication>
#include <QProcess>
#include <QDebug>
#include <terminal.h>
#include <iostream>
#include <string>
#include <QStringList>

using namespace std;

QString Terminal::command(QString cmd)
{
	if (cmd.size() > 0) {
		QList commandLine = cmd.split(QRegExp(" "));
		
		cmd = commandLine.at(0);
		commandLine.removeAt(0);
		
		QProcess process;
		process.setProgram(cmd);
   		
		if (commandLine.size() > 0) {
			QStringList parameters = commandLine;
			process.setArguments(parameters);
		}
    	process.start();
    	process.waitForFinished();
	
		QString output = QString::fromUtf8(process.readAllStandardOutput());
		QString err = QString::fromUtf8(process.readAllStandardError());
		qDebug() << err;
		qDebug() << output;
		return output;	
    }
	return "";
}

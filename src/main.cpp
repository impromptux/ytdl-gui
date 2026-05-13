#include "ytdl.h"
#include "mainactions.h"

#include <QApplication>

#include <QCoreApplication>
#include <QTranslator>


//#define tr QCoreApplication::tr
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QLocale locale = QLocale::system();
    qDebug() << "Current locale:" << locale.name();
    QTranslator translator;
    QString language = locale.languageToString(locale.language());
    qDebug() << "Current language:" << language;
    QString localeID = "en";
    if (language == "French") {
        localeID = "fr";
    }else if (language == "German"){
        localeID = "de";
        qDebug() << "German locale by Mondstern";
    }else if (language == "Spanish"){
        localeID = "es";
        qDebug() << "Spanish locale by Gallegonovato";
    }else if (language == "Estonian"){
        localeID = "et";
        qDebug() << "Estonian locale by Priit Jõerüüt";
    }else if (language == "Chinese"){
        localeID = "zh_Hans";
        qDebug() << "Chinese locale by Outbreak2096";
    }else if (language == "Dutch"){
        localeID = "nl";
        qDebug() << "Dutch locale by Heimen Stoffels";
    }else if (language == "Kabyle"){
        localeID = "kab";
        qDebug() << "Kabyle locale by Butterflyoffire";
    }
    qDebug() << "Chosen locale:" << localeID;
    if (localeID != "en"){
        QString localePath = QString(YTDL_GUI_DATA_DIR)+"locales/ytdl-gui_"+localeID+".qm" ;
        qDebug() << "Loading locale:"<< localePath;
        if (!translator.load(localePath)) {
            qWarning() << "Failed to load translation file from installation path, will try from some other path.";
            if (!translator.load("/usr/share/ytdl-gui/locales/ytdl-gui_"+localeID+".qm")) {
                if (!translator.load("/usr/local/share/ytdl-gui/locales/ytdl-gui_"+localeID+".qm")) {
                    if (!translator.load("locales/ytdl-gui_"+localeID+".qm")) {
                        qWarning() << "Failed to load translation file.";
                    }
                }
            }
        }
    }

    a.installTranslator(&translator);
    ytdl w;
    mainActions q;
    QCoreApplication::setApplicationName(QString(QCoreApplication::tr("Youtube Downloader")));
    w.setWindowTitle( QCoreApplication::applicationName() );
    w.setWindowIcon(QIcon::fromTheme("page.codeberg.impromptux.ytdl-gui"));
    QGuiApplication::setDesktopFileName("page.codeberg.impromptux.ytdl-gui");
    w.show();
    return a.exec();
}

#include "kpartswidget.h"

#include <kservice.h>
#include <ktoolbar.h>

#include <QKeyEvent>
#include <QDebug>
#include <QApplication>

KPartsWidget::KPartsWidget(QWidget *parent)
    //: KParts::MainWindow(parent, KDE_DEFAULT_WINDOWFLAGS)
{
    setAttribute(Qt::WA_DeleteOnClose);
    KService::Ptr service = KService::serviceByDesktopPath("okular_part.desktop");

    if( service )
    {
        m_part = service->createInstance<KParts::ReadOnlyPart>(0, QVariantList() << "Print/Preview");

        if(m_part)
        {
            setCentralWidget(m_part->widget());

            // we don't need toolabrs being shown
            foreach(KToolBar *toolbar, toolBars())
                toolbar->hide();
        }
    }
}

KPartsWidget::~KPartsWidget()
{

}

void KPartsWidget::setUrl(const QString &url)
{
    m_part->openUrl(url);
}

void KPartsWidget::keyPressEvent(QKeyEvent *event)
{
    qDebug() << event->key();
    event->ignore();
}

QStringList KPartsWidget::supportedMimeTypes() const
{
    return QStringList();
}

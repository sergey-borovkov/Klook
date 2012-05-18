/* KLook
 * Copyright (c) 2011-2012 ROSA  <support@rosalab.ru>
 * Authors: Julia Mineeva, Evgeniy Auzhin, Sergey Borovkov.
 * License: GPLv3
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as
 *   published by the Free Software Foundation; either version 3,
 *   or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "klookapp.h"

#include <QFileInfo>
#include <QFile>
#include <QDir>
#include <QGraphicsObject>

#include <kcmdlineargs.h>
#include <kurl.h>
#include <kicon.h>

#include "declarativeviewer.h"


KLookApp::KLookApp()
    : KUniqueApplication()
    , m_viewer( 0 )
{
    m_viewer = new DeclarativeViewer();

    QFileInfo fi( QCoreApplication::applicationFilePath() );

    QString qmlPath;

    if ( isLocal() )
        qmlPath += "/usr/share/" + fi.baseName() + "/main.qml";
    else
        qmlPath += "../src/qml/main.qml";

    m_viewer->setSource( QUrl::fromLocalFile( qmlPath) );

    QObject* rootObject = dynamic_cast<QObject*>( m_viewer->rootObject() );

    QObject::connect( m_viewer, SIGNAL( setFullScreenState() ), rootObject, SLOT( setFullScreenState() ) );
    QObject::connect( m_viewer, SIGNAL( setEmbeddedState() ), rootObject, SLOT( setEmbeddedState() ) );
    QObject::connect( m_viewer, SIGNAL( setStartWindow() ), rootObject, SLOT( setStartWindow() ) );
    QObject::connect( rootObject, SIGNAL( setGalleryView( bool ) ), m_viewer, SLOT( onSetGallery( bool ) ) );

    m_viewer->setAttribute( Qt::WA_QuitOnClose );
}

KLookApp::~KLookApp()
{
    delete m_viewer;
}

bool KLookApp::isEmbeddedParam()
{
    KCmdLineArgs* args = KCmdLineArgs::parsedArgs();

    bool embedded = args->isSet( "embedded" );

    return embedded;
}

QRect KLookApp::rectParam()
{
    KCmdLineArgs* args = KCmdLineArgs::parsedArgs();

    QRect rc;
    if ( args->isSet( "x" ) && args->isSet( "y" ) &&
         args->isSet( "w" ) && args->isSet( "h" ) )
    {
        int x, y, w, h;
        x = args->getOption( "x" ).toInt();
        y = args->getOption( "y" ).toInt();
        w = args->getOption( "w" ).toInt();
        h = args->getOption( "h" ).toInt();
        rc = QRect( x, y, w, h );
    }
    return rc;
}

QStringList KLookApp::urlsParam()
{
    KCmdLineArgs* args = KCmdLineArgs::parsedArgs();

    QStringList urls;
    for ( int i = 0; i < args->count(); i++ )
        urls << args->arg( i );

    return urls;
}

int KLookApp::newInstance()
{
    KCmdLineArgs::setCwd( QDir::currentPath().toUtf8() );
    KCmdLineArgs* args = KCmdLineArgs::parsedArgs();

    QStringList urls = urlsParam();
    QRect rc = rectParam();
    bool embedded = isEmbeddedParam();

    m_viewer->init( urls, embedded, rc );

    args->clear();

    return 0;
}

bool KLookApp::isLocal() const
{
    const QString appPath = applicationFilePath();
    return appPath.startsWith( "/usr/bin" ) || appPath.startsWith( "/usr/local/bin" );
}
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

#include <KUrl>

#include "previewprovider.h"
#include "previewgenerator.h"

PreviewProvider::PreviewProvider()
    : QDeclarativeImageProvider(Pixmap)
    , previewGenerator(PreviewGenerator::createInstance())
{
}

QPixmap PreviewProvider::requestPixmap(const QString& id, QSize* size, const QSize &requestedSize)
{
    QString str = id.left(id.lastIndexOf( '%' ));

    KUrl url(str);
    QPixmap pixmap = previewGenerator->getPreviewPixmap(url.url());
    if (requestedSize.isValid())
        pixmap = pixmap.scaled( requestedSize, Qt::KeepAspectRatio );
    if(size)
        *size = pixmap.size();

    return pixmap;
}

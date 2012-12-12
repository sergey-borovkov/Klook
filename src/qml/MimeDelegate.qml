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

import QtQuick 1.1
import Widgets 1.0

Component {
    Item {
        Image {
            id: mimeIcon
            anchors {
                left: parent.left
                leftMargin: leftItemMargin
                top: parent.top
                topMargin: iconHeightMargin
                bottomMargin: iconHeightMargin + panel.height
            }

            source: "image://mime/" + fileUrl
            sourceSize {
                width: Math.min(parent.width / 3, parent.height)
                height: Math.min(parent.height - anchors.bottomMargin, parent.width)
            }
        }

        InfoItem {
            id: name
            anchors {
                left: mimeIcon.right
                right: parent.right
            }
            y: (mimeIcon.height - mimeIcon.paintedHeight) / 2 + iconHeightMargin

            elide: Text.ElideRight
            textFormat: Text.StyledText
            maximumLineCount: 5
            text: "<b>" + fileName +"</b>"
            font.pointSize: 15
        }

        InfoItem {
            id: itemType
            anchors {
                top: name.bottom
                left: mimeIcon.right
            }

            text: mime
        }

        InfoItem {
            id: modified
            anchors {
                top: itemType.bottom
                left: mimeIcon.right
            }

            text: (statComplete)? i18n("Last Modified:") + " " + lastModified : i18n("Last Modified:")
            elide: Text.ElideNone
            wrapMode: Text.NoWrap
        }

        AnimatedImage {
            id: modifiedWaitAnimation
            anchors {
                top: itemType.bottom
                left: modified.right
                leftMargin: 10
            }

            source: "images/loader.gif"
            visible: !statComplete
        }

        InfoItem {
            id: size
            anchors {
                top: modified.bottom
                left: mimeIcon.right
            }

            text:  (statComplete)? i18n("Size:") + " " + contentSize : i18n("Size:")
        }

        AnimatedImage {
            id: sizeWaitAnimation
            anchors {
                top: modified.bottom
                left: size.right
                leftMargin: 10
            }

            source: "images/loader.gif"
            visible: !statComplete
        }

        states: [
            State {
                name: "fullscreen"; when: mainWindow.state === 'fullscreen'
                PropertyChanges { target: modifiedWaitAnimation; source: "images/white-loader.gif" }
                PropertyChanges { target: sizeWaitAnimation; source: "images/white-loader.gif" }
            }
        ]
    }
}

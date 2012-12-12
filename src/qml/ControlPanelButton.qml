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


import QtQuick 1.0

Rectangle {
    id: controlPanelButton
    anchors.verticalCenter: parent.verticalCenter
    width: buttonWidth;
    height: buttonHeight

    property string name
    property string imageUrl: "images/"+ name + ".png"; clip: true

    property int buttonWidth: 40
    property int buttonHeight: 40

    signal buttonClick()

    //set appearance properties
    radius: 6
    smooth: true
    color: "#00000000"
    state: "normal"

    Image {
        id: buttonImage
        anchors {
            fill: parent
            margins: 6
        }

        source: imageUrl
        smooth: true
        fillMode: Image.PreserveAspectFit
        opacity: 1
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent

        smooth: true
        onClicked: buttonClick()
    }

    states: [
        State {
            name: "disabled"
            PropertyChanges { target: buttonImage; opacity: 0.5 }
            PropertyChanges { target: buttonMouseArea; enabled: false }
        },
        State {
            name: "normal"
            PropertyChanges { target: buttonImage; opacity: 1 }
            PropertyChanges { target: buttonMouseArea; enabled: true }
        }
    ]

    //scale the button when pressed
    scale: buttonMouseArea.pressed ? 1.05 : 1.00
}

import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2
import backend 1.0
import imagecontainer 1.0

Window {
    visible: true
    width: 660
    height: 864
    title: qsTr("Img2txt")
    color: "#f5f5f5"

    // Here, we instantiate our Backend component
    Backend {
        id:backend
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 4

        Rectangle {
            visible: true
            Layout.fillWidth: true
            Layout.preferredWidth: 500
            height: 280
            SystemPalette { id: palette }

            FileDialog {
                id: fileDialog
                visible: fileDialogVisible.checked
                title: fileDialogSelectFolder.checked ? "Choose a folder" :
                    (fileDialogSelectMultiple.checked ? "Choose some files" : "Choose a file")
                selectMultiple: fileDialogSelectMultiple.checked
                selectFolder: fileDialogSelectFolder.checked
                nameFilters: [ "Image files (*.png *.jpg)", "All files (*)" ]
                selectedNameFilter: "Image files (*.png *.jpg)"
                sidebarVisible: fileDialogSidebarVisible.checked
                onAccepted: {
                    console.log("Accepted: " + fileUrls)
                    if (fileDialogSelectFolder.checked) {
                        // Read directory contents
                    }
                    if (fileDialogOpenFiles.checked) {
                        for (var i = 0; i < fileUrls.length; ++i)
                            // Send to backend?
                            filesModel.append({"filename" :fileUrls[i]})
                    }
                }
                onRejected: { console.log("Rejected") }
            }

            ScrollView {
                id: scrollView
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: bottomBar.top
                    leftMargin: 12
                }
                ColumnLayout {
                    spacing: 6
                    Item { Layout.preferredHeight: 4 } // padding
                    Label {
                        font.bold: true
                        text: "Please Select Source:"
                    }
                    CheckBox {
                        id: fileDialogSelectFolder
                        text: "All Images in a Folder"
                        Binding on checked { value: fileDialog.selectFolder }
                    }
                    CheckBox {
                        id: fileDialogSelectMultiple
                        text: "Select Multiple Files"
                        Binding on checked { value: fileDialog.selectMultiple }
                    }
                    CheckBox {
                        id: fileDialogOpenFiles
                        text: "Add Files After Accepting"
                        checked: true
                    }
                    CheckBox {
                        id: fileDialogSidebarVisible
                        text: "Show Sidebar"
                        checked: fileDialog.sidebarVisible
                        Binding on checked { value: fileDialog.sidebarVisible }
                    }
                    CheckBox {
                        id: fileDialogVisible
                        text: "Visible"
                        Binding on checked { value: fileDialog.visible }
                    }
                    Label {
                        text: "<b>current view folder:</b> " + fileDialog.folder
                    }
                    Label {
                        text: "<b>name filters:</b> {" + fileDialog.nameFilters + "}"
                    }
                    Label {
                        text: "<b>current filter:</b>" + fileDialog.selectedNameFilter
                    }
                    Label {
                        text: "<b>chosen files:</b> " + fileDialog.fileUrls
                    }
                    Label {
                        text: "<b>chosen single path:</b> " + fileDialog.fileUrl
                    }
                }
            }

            Rectangle {
                id: bottomBar
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: buttonRow.height * 1.2
                color: Qt.darker(palette.window, 1.1)
                border.color: Qt.darker(palette.window, 1.3)
                Row {
                    id: buttonRow
                    spacing: 6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    height: implicitHeight
                    width: parent.width
                    Button {
                        text: "Open"
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: fileDialog.open()
                    }
                    Button {
                        text: "Pictures"
                        tooltip: "go to my Pictures directory"
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: fileDialog.shortcuts.hasOwnProperty("pictures")
                        onClicked: fileDialog.folder = fileDialog.shortcuts.pictures
                    }
                    Button {
                        text: "Home"
                        tooltip: "go to my home directory"
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: fileDialog.shortcuts.hasOwnProperty("home")
                        onClicked: fileDialog.folder = fileDialog.shortcuts.home
                    }
                }
            }
        }

        ListModel {
            id: filesModel
/*          ListElement {
                filename: "animage.jpg"
            } */
        }
        TableView {
            Layout.fillWidth: true
            TableViewColumn {
                role: "filename"
                title: "filename"
            }
            model: filesModel
            onClicked: {
                startButton.selectedRow = row
                console.log("Selected: " + filesModel.get(row).filename);
            }
        }
/*
        Rectangle {
            border.width: 1
            height: 2
            Layout.fillWidth: true
            anchors.margins: 20
            border.color: "#A0A0A0"
        }
*/
        Column {
            id: optionsColumn
            ExclusiveGroup { id: buttonGroup }
            spacing: 4

            Label {
                font.bold: true
                text: "Please Choose Image Type:"
            }

            // General image option?

            RadioButton {
                checked: true
                text: qsTr("Document (OCR)")
                exclusiveGroup: buttonGroup
            }

            RadioButton {
                text: qsTr("CAPTCHA")
                exclusiveGroup: buttonGroup
            }

            RadioButton {
                text: qsTr("Cityscape")
                exclusiveGroup: buttonGroup
            }

            RadioButton {
                text: qsTr("Car Plates")
                exclusiveGroup: buttonGroup
            }

            Row {
                spacing: 2
                RadioButton {
                    text: qsTr("Only Search For This:")
                    exclusiveGroup: buttonGroup
                }

                TextField{
                    id:txtToFind
                }
            }
        }

        Row {
            spacing: 5
            Button{
                id:startButton
                text:qsTr("Start")
                default property int selectedRow: -1
                onClicked:{
                    if (selectedRow == -1) {
                        console.log("Process: please selet an image")
                    } else {
                        console.log("Process: " + filesModel.get(selectedRow).filename)
                        txt.text = backend.launch(filesModel.get(selectedRow).filename, imageContainer, -1, txtToFind.text)
                    }
                }
            }

            ProgressBar {
                value: 0.5
            }

            Button{
                id:stopButton
                text:qsTr("Stop")
                onClicked:{
                    console.log("Stop")
                }
            }

        }
/*
        Rectangle {
            border.width: 1
            height: 2
            Layout.fillWidth: true
            anchors.margins: 20
            border.color: "#A0A0A0"
        }
*/
        Label {
            font.bold: true
            text: "Results:"
        }

        Row {
            spacing: 10

            Rectangle {
                width: 320
                height: 200
                ImageContainer {
                    id: imageContainer
                    anchors.fill: parent
                }
            }

            Rectangle {
                width: 320
                height: 200
                TextArea{
                    anchors.fill: parent
                    id:txt
                    text: "Text"
                }
            }
        }
    }

}

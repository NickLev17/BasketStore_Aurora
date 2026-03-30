/**
 * @brief Стартовая страница.
 * @details Содержит список глобальных переменных.
 * Информацию о начальной странице приложения.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    id: app

    property var listElectronics: []
    property var listJewelery: []
    property var listWomensClothing: []
    property var listMensClothing: []

    property var listHistoryBay:[]
    property var listMyBasket:[]

    property string myName:""
    property string mySecondName:""
    property string myFamilyName:""
    property string myEmail:""
    property string myPassword:""


    property bool myEducation:false
    property bool myEntertainment:false
    property bool mySport:false
    property bool myFamily:false
    property string myFieldOther:""
    property bool myMailing:false
    property bool myPersonalData:true




    objectName: "applicationWindow"
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/DefaultCoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}

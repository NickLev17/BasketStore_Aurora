/**
 * @brief Страница обложки приложения
 * @details Позволяет задать иконку приложения и основной фон
 * при "свёрнутом" приложении.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    objectName: "defaultCover"

    Rectangle
    {
        anchors.fill: parent
        color: "#6699FF"
    }

    CoverTemplate {
        objectName: "applicationCover"
        primaryText: "Basket"
        secondaryText: qsTr("Корзинка")
        icon {
            source: Qt.resolvedUrl("../icons/basket.png")
            sourceSize { width: icon.width; height: icon.height }
        }
    }
}

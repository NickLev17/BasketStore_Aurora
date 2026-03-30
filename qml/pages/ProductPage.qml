/**
 * @brief Страница товаров.
 * @details Содержит список товаров, доступных пользователю в данной категории товаров.
 * Содержит карточки товаров.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "productPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#5577ee"//"#6699FF" // "#2c3e50"

    /**
 * @brief Модель данных
 */
    ListModel {
        id: storeModel
    }

    property var listProduct: []
    property int productCount: 0

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent
        contentHeight: Screen.height * 1.5

        Column {
            anchors {
                fill: parent
                leftMargin: Theme.horizontalPageMargin
                rightMargin: Theme.horizontalPageMargin
            }
            spacing: Theme.paddingLarge

            PageHeader {
                objectName: "pageHeader"
                title: (qsTr("Products")+"(" + productCount + ")")
                titleColor: "white"
            }

            Repeater {

                model: storeModel.count

                delegate: BackgroundItem {
                    width: parent.width
                    height:300
                    onClicked:
                    {
                        showProductDetails(index)
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 8
                        color: highlighted ? Theme.highlightColor : "#f8f8f8"
                        border.color: "black"
                        border.width: 5
                        Row {
                            anchors.fill: parent
                            anchors.margins: Theme.paddingSmall
                            spacing: Theme.paddingMedium

                            Image {
                                width: 220
                                height: 220
                                source: storeModel.get(index).Image || ""
                                fillMode: Image.PreserveAspectFit
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Column {
                                width: parent.width - 90
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    id:recMainTitle
                                    width: parent.width*0.7
                                    text: storeModel.get(index).Title || "Без названия"
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: Theme.fontSizeMedium
                                    horizontalAlignment: Text.AlignHCente
                                    color: "#6699FF"//Theme.highlightColor
                                }
                            }
                        }
                    }
                }
            }
        }

        VerticalScrollDecorator{}
    }

    /**
     * @brief Загрузка товаров и инициализация ими модели.
     */
    function loadProducts() {
        console.log("Загружаем продукты...")
        storeModel.clear()
        productCount = 0
        var electronics = listProduct || []
        console.log("Найдено продуктов:", electronics.length)

        for (var i = 0; i < electronics.length; i++) {
            var product = electronics[i]
            var modelItem = {}

            for (var key in product) {
                modelItem[key] = product[key]
            }

            storeModel.append(modelItem)
            productCount++
            console.log("Добавлен продукт:", modelItem.Title)
        }
        console.log("Модель заполнена:", storeModel.count, "элементов")
    }

    /**
     * @brief Вывод информации о товаре.
     */
    function showProductDetails(index) {
        if (index >= 0 && index < storeModel.count) {
            var product = storeModel.get(index)
            console.log("Показываем продукт:", product.Title)
            console.log("Описание :", product.Description)

            pageStack.push(Qt.resolvedUrl("CardPage.qml"),
                           {"productTitle": product.Title,
                               "productImage": product.Image,
                               "productPrice": product.Price,
                               "productDescription": product.Description,
                               "productRate":product.Rate,
                               "productVoices": product.Voices,
                               "productCategory": product.Category})
        }
    }

    Component.onCompleted:
    { target: page
        loadProducts()
    }
}

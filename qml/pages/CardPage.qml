/**
 * @brief Страница Карточка товара
 * @details Содержит информацию о товаре.
 * Изображение, наименование, рейтинг, количество оценок, описание товара.
 * Кнопки "Купить сейча" и "В Корзину".
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components" as Components
import Database 1.0

Page {
    objectName: "CardPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#5577ee"//"#6699FF"//"#2c3e50"

    property string productTitle: ""
    property string productImage: ""
    property double productPrice: 0
    property string productDescription: ""
    property double productVoices: 0
    property double productRate: 0
    property int  count:0
    property string productCategory:""
    /**
     * @brief Обьект базы данных.
     * @details Позволяет работать с базой данных из кода QML.
     */
    Database
    {id: db}

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: Screen.height * 1.3  // Обязательно!

        Column {
            id: mainColumn
            width: parent.width - (2 * Theme.horizontalPageMargin)
            x: Theme.horizontalPageMargin
            spacing: Theme.paddingLarge

            PageHeader {
                objectName: "pageHeader"
                title: qsTr("Card")
                titleColor: "white"
            }

            Rectangle {
                id: rec
                width: parent.width
                height: content.implicitHeight*1.2
                radius: 10
                color: "white"
                border.color: "black"
                border.width: 5
                Column {
                    id: content
                    width: parent.width * 0.95
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: Theme.paddingLarge
                    anchors.bottomMargin: Theme.paddingLarge
                    spacing: Theme.paddingLarge

                    Image {
                        id: image
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: Math.min(300, parent.width * 0.8)
                        height: 350
                        source: productImage
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            Label {
                id: labelTitle
                width: parent.width
                text: productTitle
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "white"
                font.pixelSize: Theme.fontSizeLarge
            }

            Rectangle
            {
                height: 1
                width: parent.width
            }

            Row {
                width: parent.width
                height: 50
                spacing: Theme.paddingLarge

                Row {
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        text: qsTr("Оценок")+": " + productVoices.toString()
                        color: "white"
                        font.pixelSize: Theme.fontSizeMedium
                    }

                    Item {

                        width: (parent.width/4);
                        height: 1
                    }

                    Label
                    {
                        text:qsTr("Рейтинг")+":"

                    }

                    Label
                    {
                        text:+ productRate.toString()

                    }

                    Image {
                        width:40
                        height:40
                        source: "../icons/stars.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            Rectangle
            {
                height: 1
                width: parent.width
            }

            Row {
                id: rowPrice
                width: parent.width
                height: 50
                spacing: Theme.paddingMedium

                Item { width: (parent.width - 150) / 2.5; height: 1 }

                Row {
                    spacing: 8
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        text: qsTr("Цена")+":"
                        color: "white"
                        font.pixelSize: Theme.fontSizeMedium
                    }

                    Label {
                        text: productPrice.toFixed(2)
                        color: "gold"
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                    }

                    Label {
                        text: "$"
                        color: "gold"
                        font.pixelSize: Theme.fontSizeLarge
                    }
                }

                Item { width: (parent.width - 150) / 2; height: 1 }
            }

            Label
            {
                text:qsTr("Описание товара")+": "
            }

            Label {
                id: labelDescription
                width: parent.width
                height: implicitHeight
                text: productDescription
                color: "white"
                font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.WordWrap
                maximumLineCount: 10
                horizontalAlignment: Text.AlignJustify
            }

            Item
            {
                height: 50
                width:parent.width
            }

            Column {
                width: parent.width
                height: 60
                spacing: Theme.paddingLarge

                Components.PanelButton {
                    id: panelButton
                }
            }
        }

        VerticalScrollDecorator {}
    }

    Connections
    {
        target:panelButton
        onAddProduct:{
            if(!db.stateConnect())
            {
                db.connect()
            }
            console.log(db.connected)
            db.createTable("Basket")
            addProductDatabase()
        }
    }

    Connections
    {
        target:panelButton
        onDeleteProduct:
        {
            deleteProductDatabase()
        }
    }

    Connections
    {
        target:panelButton
        onBayProduct:{
            if(!db.stateConnect())
            {
                db.connect()
            }
            console.log(db.connected)
            db.createTable("History")
            bayProductDatabase()
        }
    }

    property var tmp: []
    property int productCount: 0

    ListModel {
        id: storeModel
    }

    /**
     * @brief Добавление товара в базу данных.
     */
    function addProductDatabase()
    {
        db.addRecord("Basket",productTitle,productPrice,productImage,productCategory,productDescription,productRate,productVoices)
        db.readTableData("Basket")
        listMyBasket=[]
        listMyBasket=db.getTableData("Basket")
    }

    /**
     * @brief Удаление товара из базы данных.
     */
    function deleteProductDatabase()
    {

        tmp =db.getTableData("Basket")
        console.log("Size tmp ",tmp.length)

        if(tmp.length==0)
        {
            console.log("EMPTY MAP")
            return;
        }

        db.createTable("Basket")
        db.removeRowTable("Basket",productTitle)
        db.readTableData("Basket")
        console.log("DELETE ",productTitle)
        listMyBasket=[]
        listMyBasket=db.getTableData("Basket")
    }

    /**
     * @brief Покупка товара. Добавление товара в историю покупок.
     */
    function bayProductDatabase()
    {
        listHistoryBay=[]
        db.addRecord("History",productTitle,productPrice,productImage,productCategory,productDescription,productRate,productVoices)
        db.readTableData("History")
        listHistoryBay=db.getTableData("History")
    }
}


/**
 * @brief Страница категорий товаров.
 * @details Содержит кнопки, соответсвующие определенным категориям товаров.
 * Содержит анимации, изменения свойст прозрачности.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import Database 1.0
import "../components" as Components


Page {
    objectName: "сategoriesPage"
    allowedOrientations: Orientation.All
    backgroundColor:"#5577ee"//"#6699FF" //"#2c3e50"

    /**
     * @brief Обьект базы данных.
     * @details Позволяет работать с базой данных из кода QML.
     */
    Database
    {id: myDatabase}

    Column{
        anchors {
            fill: parent
            leftMargin: Theme.horizontalPageMargin
            rightMargin: Theme.horizontalPageMargin
        }

        spacing: Theme.paddingLarge
        PageHeader {
            objectName: "pageHeader"
            title: qsTr("Сategories")
            titleColor: "white"
        }

        /**
         * @brief Кнопка категории "Электроника"
         */
        Button
        {
            id: btn_electronics
            implicitHeight: Theme.itemSizeLarge
            width: parent.width
            visible: true
            backgroundColor:"#6699FF"
            opacity: 0
            text: qsTr("Electronics")
            icon.source: "../icons/device.png"
            icon.height: ( btn_electronics.height -5)
            icon.width: ( btn_electronics.height -5)
            onClicked:
            {console.log("electronics size ",app.listElectronics.length)

                var electronics=app.listElectronics
                for (var i in electronics)//listObject
                {
                    var tmp=electronics[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("ProductPage.qml"),{"listProduct":electronics})
            }

            PropertyAnimation
            {
                id:animOpacityElectronics
                target:btn_electronics
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityElectronics.running=true
            }
        }

        /**
         * @brief Кнопка категории "Мужская одежда"
         */
        Button
        {
            id: btn_mens_clothing
            implicitHeight: Theme.itemSizeLarge
            width: parent.width
            visible: true
            backgroundColor:"#6699FF"
            opacity: 0
            text: qsTr("Men's clothing")
            icon.source: "../icons/hanger.png"
            icon.height: ( btn_mens_clothing.height -5)
            icon.width: ( btn_mens_clothing.height -5)
            onClicked: {
                console.log("mens size ",app.listMensClothing.length)
                var mensClothing=app.listMensClothing
                for (var i in mensClothing)//listObject
                {
                    var tmp=mensClothing[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("ProductPage.qml"),{"listProduct":mensClothing})
            }

            PropertyAnimation
            {
                id:animOpacityMens
                target:btn_mens_clothing
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityMens.running=true
            }
        }

        /**
         * @brief Кнопка категории "Женская одежда"
         */
        Button
        {
            id: btn_womens_clothing
            implicitHeight: Theme.itemSizeLarge
            width: parent.width
            visible: true
            opacity: 0
            backgroundColor: "#6699FF"
            text: qsTr("Women's clothing")
            icon.source: "../icons/herz.png"
            icon.height: ( btn_womens_clothing.height -5)
            icon.width: (btn_womens_clothing.height -5)
            onClicked:
            {
                console.log("womens size ",app.listWomensClothing.length)
                var womensClothing=app.listWomensClothing
                for (var i in womensClothing)//listObject
                {
                    var tmp=womensClothing[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("ProductPage.qml"),{"listProduct":womensClothing})
            }

            PropertyAnimation
            {
                id:animOpacityWomens
                target:btn_womens_clothing
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityWomens.running=true
            }
        }

        /**
         * @brief Кнопка категории "Украшения"
         */
        Button
        {
            id: btn_jewelry
            implicitHeight: Theme.itemSizeLarge
            width: parent.width
            visible: true
            backgroundColor: "#6699FF"
            opacity: 0
            text: qsTr("Jewelry")
            icon.source: "../icons/decoration.png"
            icon.height: ( btn_jewelry.height -5)
            icon.width: (btn_jewelry.height -5)
            onClicked:
            {
                console.log("jewelry size ",app.listJewelery.length)
                var Jewelery=app.listJewelery
                for (var i in Jewelery)//listObject
                {
                    var tmp=Jewelery[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("ProductPage.qml"),{"listProduct":Jewelery})
            }

            PropertyAnimation
            {
                id:animOpacityJewelry
                target:btn_jewelry
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityJewelry.running=true
            }
        }

        Rectangle
        {
            id: spacer

            width: parent.width
            height: 200
            color: Theme.backgroundGlowColor

        }


        /**
         * @brief Кнопка категории "Моя Корзина"
         */
        Button
        {
            id: btn_basket
            implicitHeight: Theme.itemSizeLarge
            anchors.topMargin: Theme.paddingLarge * 2
            width: parent.width
            visible: true
            backgroundColor: "#6699FF"
            opacity: 0
            text: qsTr("My Basket")
            icon.source: "../icons/white_basket.png"
            icon.height: ( btn_basket.height -5)
            icon.width: (btn_basket.height -5)
            onClicked: {console.log("click")
                var basket=app.listMyBasket
                for (var i in basket)//listObject
                {
                    var tmp=basket[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("BasketPage.qml"),{"listProduct":basket})
            }

            PropertyAnimation
            {
                id:animOpacityBasket
                target:btn_basket
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityBasket.running=true
            }
        }

        /**
         * @brief Кнопка категории "История покупок"
         */
        Button
        {
            id: btn_historyBay
            // x:20
            implicitHeight: Theme.itemSizeLarge
            anchors.topMargin: Theme.paddingLarge * 2
            width: parent.width
            visible: true
            backgroundColor: "#6699FF"
            opacity: 0
            text: qsTr("Order history")
            icon.source: "../icons/bought.png"
            icon.height: (btn_historyBay.height -5)
            icon.width: ( btn_historyBay.height -5)
            onClicked: {console.log("click")
                var HistoryBay=app.listHistoryBay
                for (var i in HistoryBay)//listObject
                {
                    var tmp=HistoryBay[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                pageStack.push(Qt.resolvedUrl("HistoryPage.qml"),{"listProduct":HistoryBay})
            }

            PropertyAnimation
            {
                id:animOpacityHistory
                target:btn_historyBay
                property: "opacity"
                to:1

                duration:2000
            }

            Component.onCompleted:
            {
                animOpacityHistory.running=true
            }
        }
    }

    Component.onCompleted:
    {target: page
        myDatabase.connect()
        myDatabase.createTable("History")
        myDatabase.createTable("Basket")
        listMyBasket=[]
        listHistoryBay=[]
        listMyBasket=myDatabase.getTableData("Basket")

        listHistoryBay=myDatabase.getTableData("History")
        myDatabase.disconnect()

        console.log("sad")

    }
}

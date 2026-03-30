/**
 * @brief Начальная страница приложения.
 * @details Позволяет пользователю перейти на страницу авторизации.
 * При успешной авторизации становится доступным переход к дальнейшим страницам.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import storemanager 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#5577ee"//"#6699FF" //"#2c3e50"

    /**
 * @brief Менеджер сетевого взаимодействия
 * @details Позволяет отправлять запросы и получать ответы по сети интернет.
 */
    StoreManager
    {
        id: storeManager
    }

    PageHeader {
        objectName: "pageHeader"
        title: qsTr("Корзинка Магазин")
        titleColor: "white"
        extraContent.children: [
            IconButton {
                objectName: "authorizationButton"
                icon.source: "../icons/key.png"
                icon.height: 60
                icon.width: 100
                anchors.verticalCenter: parent.verticalCenter
                onClicked: pageStack.push(Qt.resolvedUrl("UserAuthorization.qml"))
            }
        ]
    }

    Item
    {
        id:rec_arrow
        anchors.bottom: label_authorization.top
        anchors.left: Theme.paddingLarge
        height: 350
        width: 200

        Image
        {
            id:image_arrow
            anchors.top: rec_arrow.top
            source: "../icons/arrow.png"
        }
    }

    Label
    {
        id: label_authorization
        anchors.bottom: btn_start.top
        anchors.horizontalCenter: btn_start.horizontalCenter
        text:qsTr("Для работы с приложением небходимо авторизоваться")
        wrapMode: Text.WordWrap
        width: parent.width*0.9
        font.pixelSize: Theme.fontSizeMedium
        horizontalAlignment: Text.AlignHCenter
    }

    /**
     * @brief Стартовая кнопка приложения.
     * @details Обеспечивает проверку авторизации пользователя и переход к следующей странице.
     */
    Rectangle
    {
        id: btn_start
        anchors.centerIn: parent
        anchors.left: Theme.paddingLarge
        anchors.right: Theme.paddingLarge
        radius: 25
        height: parent.height/4.5
        width: parent.width/1.5
        border.color: "white"
        border.width: 5
        visible: true
        opacity: 0
        color: "#6999FA"

        signal initialisationButton()

        onInitialisationButton: {
            label_authorization.visible=false
            rec_arrow.visible=false
            animOpacity.running=true
        }

        Text
        {
            id: txt_start
            anchors.centerIn: parent
            color: "white"
            text: qsTr("Go")
            font.pixelSize: Theme.fontSizeLarge
        }

        MouseArea
        {
            id: mouseArea_start
            anchors.fill: parent

            hoverEnabled: true
            onEntered: {
                btn_start.border.width = 5
            }

            onExited: {
                btn_start.border.width = 10
            }
            onClicked:{

                if((myPassword=="")|(myEmail==""))
                {
                    return
                }

                listElectronics.length = 0
                listJewelery.length =0
                listMensClothing.length=0
                listWomensClothing.length=0

                if(storeManager.state==true)
                {
                    pageStack.push(Qt.resolvedUrl("СategoriesPage.qml"))
                    console.log("SECCESS PARSING")
                    var products=storeManager.getAllObjects()
                    var size = Object.keys(products).length;
                    console.log("Количество продуктов:", size);
                    for (var key in products) {
                        var product = products[key];

                        console.log("///////////")
                        for (var key2 in product) {
                            var prod = product[key2];
                            if( JSON.stringify(prod)=='"electronics"')
                            {
                                listElectronics.push(product)
                            }
                            if( JSON.stringify(prod)=='"jewelery"')
                            {
                                listJewelery.push(product)
                            }

                            if( JSON.stringify(prod)=='"women\'s clothing"')
                            {
                                listWomensClothing.push(product)
                            }
                            if( JSON.stringify(prod)=='"men\'s clothing"')
                            {
                                listMensClothing.push(product)
                            }
                        }
                    }
                }
                else
                {
                    console.log("NOT SECCESS PARSING")
                }

                console.log("Electronics",listElectronics.length)
                console.log("Jewelery ",listJewelery.length)
                console.log("Mens",listMensClothing.length)
                console.log("Womens",listWomensClothing.length)

                for (var i in listWomensClothing)//listObject
                {
                    var tmp=listWomensClothing[i] //object

                    for(var i2 in tmp)// fieldObject
                    {
                        var tmp2=tmp[i2]
                        console.log(tmp2)
                    }
                }
                btn_start.border.width=5
            }
        }

        /**
         * @brief Анимация изменения прозрачности стартовой кнопки приложения.
         */
        PropertyAnimation
        {
            id:animOpacity
            target:btn_start
            property: "opacity"
            to:1

            duration:2000
        }
    }


    Component.onCompleted: {
        if (myPassword=="") {
            btn_start.visible = false
            label_authorization.visible=true
            rec_arrow.visible=true
        } else {
            btn_start.visible = true
            storeManager.initialisation()
            btn_start.initialisationButton()
        }
    }
}

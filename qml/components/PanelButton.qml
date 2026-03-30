/**
 * @brief Элемент PanelButton.
 * @details Содержит кнопки "Купить сейчас" и "В корзину"
 * Позволяет при при нажати на кнопку "В корзину" предоставлять
 * пользователю счётчик добавленных в корзину товаров.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

Item
{
    /**
     * @signal Испускается при добавлении товара в корзину.
     */
    signal addProduct();

    /**
     * @signal Испускается при удалении товара из корзины товара в корзину.
     */
    signal deleteProduct();

    /**
     * @signal Испускается при покупке товара и добавлении в историю покупок.
     */
    signal bayProduct();

    Row {
        width: parent.width

        Button {
            id: btn_bayNow
            height: 50
            width: 300
            text: qsTr("Купить сейчас")
            backgroundColor:"#40BF6A"
            onClicked: {
                bayProduct()
            }
        }

        Item { width:100; height: 1 }

        Button {
            id: btn_basket
            height: 50
            width: 250
            text: qsTr("В корзину")
            backgroundColor: "#FFA500"

            /**
             * @brief Функция визуализации кнопок
             */
            function showButton()
            {
                btn_minus.visible=true
                btn_plus.clicked(true)
                btn_plus.visible=true


                txt_count.visible=true
                txt_count.text="1"
            }

            /**
             * @brief Функция начального состояния элементов.
             */
            function startButton()
            {
                btn_basket.enabled=true
                txt_count.text=""
                count=0
                btn_basket.text= qsTr("В корзину")
                txt_count.visible=false

                btn_minus.visible=false
                btn_plus.visible=false

            }
            onClicked:
            {
                btn_basket.enabled=false
                showButton()
                btn_basket.text=""
            }

            Row
            {
                Button{
                    id:btn_minus
                    height:btn_basket.height
                    visible: false
                    width:70
                    backgroundColor: "#FFA500"
                    text:"-"
                    onClicked:{
                        count-=1

                        if(count>=1)
                        {
                            deleteProduct()
                            console.log("count= ",count)
                            txt_count.text=count.toString()
                            return
                        }
                        else
                        {
                            deleteProduct()
                            btn_basket.startButton()
                            console.log("count= ",count)
                            return;
                        }
                    }
                }

                Text {
                    id:txt_count
                    width:110;
                    text:"1"
                    color: "white"
                    visible: false
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pixelSize: Theme.fontSizeMedium
                    height: (btn_basket.height-10) }
                Button{
                    id:btn_plus
                    visible: false
                    height:btn_basket.height
                    backgroundColor: "#FFA500"
                    width:70
                    text:"+"
                    onClicked: {count+=1
                        txt_count.text=count.toString()
                        addProduct()
                        console.log("count= ",count)
                    }
                }
            }
        }
    }
}

/**
 * @brief Страница раздела "Моя Корзина"
 * @details Содержит информацию о добавленных
 * пользователем в корзину товарах.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import Database 1.0

Page {
  objectName: "basketPage"
  allowedOrientations: Orientation.All
  backgroundColor:"#5577ee"//"#6699FF"// "#2c3e50"

  /**
   * @brief Модель данных
   */
  ListModel {
    id: storeModel
  }

  /**
   * @brief Обьект базы данных.
   * @details Позволяет работать с базой данных из кода QML.
   */
  Database
  {
    id:db
  }

  property var listProduct: []
  property int productCount: 0
  property double allPriceBay:0
  property bool state: false

  SilicaFlickable
  {
    id: flick
    anchors.fill: parent
    contentHeight: (450*productCount)

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

      Rectangle
      {
        id: recPrice
        radius: 15
        height: 80
        width: parent.width
        Label
        {
          id: textLabelPrice
          color: "white"
          anchors.horizontalCenter:  recPrice.horizontalCenter
          anchors.verticalCenter: recPrice.verticalCenter
          text: qsTr("Цена всех товаров")+": "+allPriceBay.toFixed(2)+ " $"
          font.pixelSize: Theme.fontSizeMedium
        }
        color: "#FFA500"

        /**
         * @brief Установка текста по умолчанию
         */
        function setDefaultText()
        {
          textLabelPrice.text=qsTr("Ваша корзина пуста")
          rowButton.visible=false
        }
      }

      Item
      {
        id:spacer
        width:parent.width
        height:150
      }

      /**
       * @brief Изображение товара
       * @details Позволяет отобразить товар пользователю.
       */
      Image
      {
        id: imageIcon
        anchors.horizontalCenter: recPrice.horizontalCenter
        visible: false
        width: 400
        height:400
        source: "../icons/white_basket.png"
        fillMode: Image.PreserveAspectFit
      }

      Row {
        id:rowButton
        height: 50
        width: parent.width
        spacing: 20

        Button
        {
          id:btn_update
          text: qsTr("Обновить")
          width:290
          height: 40
          onClicked:
          {
            updateDataBasket()
          }
        }

        Button
        {
          height: 40
          text: qsTr("Очистить корзину")
          onClicked:
          {
            if(!db.stateConnect())
            {
              db.connect()
            }
            db.removeTableDatabase("Basket")
            listProduct=[]
            listMyBasket=[]
            allPriceBay=0
            storeModel.clear()
            productCount=0
            loadProducts()
            stateEmptyDatabase()
          }
        }
      }


      Rectangle
      {
        id:spacer_1
        height: 5
        width: rowButton.width
        color:"lightgreen"//"#5577ee"
      }

      Row {
        id:rowSort
        height: 60
        width: parent.width
        spacing: 20

        Label{
          id:labelSortName
          width:211
          text:qsTr("Сортировка")+":"
          anchors.verticalCenter: rowSort.verticalCenter
        }

        Button
        {
          width:100
          height: 70
          icon.source: "../icons/arrowUp.png"
          icon.height: 70
          icon.width: 70
          onClicked:
          {
            sortDataBasket("ASC")
          }
        }

        Button
        {
          height: 70
          width:100
          icon.source: "../icons/arrowDown.png"
          icon.height: 70
          icon.width: 70
          onClicked:
          {
            sortDataBasket("DESC")
          }
        }

        Button
        {
          height: 70
          width:180
          text: qsTr("Отмена")
          onClicked:
          {
            btn_update.clicked(true)
          }
        }
      }
      Rectangle
      {
        id:spacer_2
        height: 5
        width: rowButton.width
        color:"lightgreen"//"#5577ee"
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
            id: content
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
                  color:"#6699FF"
                  text: storeModel.get(index).Title || "Без названия"
                  wrapMode: Text.WordWrap
                  font.pixelSize: Theme.fontSizeMedium
                  horizontalAlignment: Text.AlignHCenter
                  maximumLineCount: 3
                  elide: Text.ElideRight
                }

                Label {
                  width: parent.width
                  color:"#6699FF"
                  text: qsTr("Цена")+": "+ storeModel.get(index).Price + " $"
                  font.pixelSize: Theme.fontSizeSmall
                  horizontalAlignment: Text.AlignHCenter
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
   * @brief Загрузка товаров.
   * @details Отвечает за загрузку товаров и инициализацию модель ими.
   */
  function loadProducts() {
    console.log("Загружаем продукты...")
    imageIcon.visible=false
    rowButton.visible=true
    spacer.visible=false;
    rowSort.visible=true
    spacer_1.visible=true
    spacer_2.visible=true
    for (var i in listProduct) {
      var product = listProduct[i]
      var modelItem = {}
      for (var key in product) {
        modelItem[key] = product[key]

        if(key=="Price")
        {
          allPriceBay+=product[key]
        }
      }

      storeModel.append(modelItem)
      productCount++
      console.log("Добавлен продукт:", modelItem.Title)
    }

    console.log("Всего потрачено ",allPriceBay)

    if(productCount==0)
    {
      console.log("LIST PRODUCT>LENGTH ",listProduct.length)
      stateEmptyDatabase()
      return
    }

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
                       "productRate": product.Rate,
                       "productVoices": product.Voices})
    }
  }

  Component.onCompleted:
  { target: page
    loadProducts()
  }

  /**
   * @brief Обновление данныз в корзине
   */
  function updateDataBasket()
  {
    storeModel.clear()
    productCount=0
    allPriceBay=0
    if(!db.stateConnect())
    {
      db.connect()
    }
    listMyBasket=db.getTableData("Basket")
    listProduct=listMyBasket
    loadProducts()
  }

  /**
   * @brief Сортировка данных в корзине.
   */
  function sortDataBasket(pattern)
  {
    storeModel.clear()
    productCount=0
    allPriceBay=0
    if(!db.stateConnect())
    {
      db.connect()
    }
    listMyBasket=db.sortDataTable("Basket",pattern)
    listProduct=listMyBasket
    loadProducts()
  }

  /**
   * @brief Установка элементов в начальное состояние.
   */
  function stateEmptyDatabase()
  {
    spacer.visible=true
    recPrice.setDefaultText()
    imageIcon.visible=true
    rowButton.visible=false
    storeModel.clear()
    spacer_1.visible=false
    spacer_2.visible=false
    rowSort.visible=false
  }
}

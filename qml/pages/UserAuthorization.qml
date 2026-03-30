/**
 * @brief Страница авторизации профиля пользователя.
 * @details Позволяет задать основную информацию о пользователе.
 */
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
       objectName: "userAuthorizationPage"
       allowedOrientations: Orientation.All
       backgroundColor:"#5577ee"

       SilicaFlickable {
              objectName: "flickable"
              anchors.fill: parent
              contentHeight: Screen.height * 2

              PageHeader {
                     id:_pageHeader
                     objectName: "pageHeader"
                     title: qsTr("Информация о пользователе")
              }

              Column {
                     id: layout
                     objectName: "layout"
                     width: parent.width
                     spacing: 5
                     y:100

                     Label {
                            objectName: "nameText"
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Имя")
                     }

                     TextField {
                            id: textField_Name
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            placeholderText: qsTr("Введите имя")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Label {
                            objectName: "familyText"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Фамилия")
                     }

                     TextField {
                            id: textField_Family
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            placeholderText: qsTr("Введите фамилию")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Label {
                            objectName: "secondNameText"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Отчество")
                     }

                     TextField {
                            id: textField_SecondName
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            placeholderText: qsTr("Введите Отчество")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Label {
                            objectName: "emailText"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Электронная почта")
                     }

                     TextField {
                            id: textField_Email
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            text:login
                            placeholderText: qsTr("Введите адрес эл. почты")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Rectangle
                     {
                            id: _spacer_4
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 10
                            color: "lightgreen"
                     }

                     Label {
                            objectName: "passwordText"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Придумайте пароль")
                     }

                     TextField {
                            id: textField_password
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            placeholderText: qsTr("Введите пароль")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            echoMode: TextInput.Password
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Label {
                            objectName: "passwordTextReplay"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Повторите пароль")
                     }

                     TextField {
                            id: textField_passwordReplay
                            anchors {
                                   left: parent.left
                                   right: parent.right
                                   leftMargin: Theme.horizontalPageMargin
                                   rightMargin: Theme.horizontalPageMargin
                                   topMargin: Theme.paddingLarge
                            }
                            text:myPassword
                            placeholderText: qsTr("Введите пароль")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                            echoMode: TextInput.Password
                            errorHighlight: (textField_passwordReplay.text!=textField_password.text)? true:false
                            EnterKey.enabled: true
                                EnterKey.iconSource:"../icons/enterKey.png"
                     }

                     Rectangle
                     {
                            id: _spacer_1
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 10
                            color: "lightgreen"
                     }

                     Label {
                            id: _txt_information
                            objectName: "informationText"
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            color: palette.highlightColor
                            font.pixelSize: Theme.fontSizeSmall
                            textFormat: Text.RichText
                            wrapMode: Text.WordWrap
                            text: qsTr("Выберите интересующие Вас темы")
                     }

                     Column
                     {
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            spacing: 5

                            TextSwitch
                            {
                                   id:switchEducation
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          right: parent.right
                                   }
                                   text:  qsTr("Образование")
                            }

                            TextSwitch
                            {
                                   id:switchEntertainment
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          right: parent.right
                                   }
                                   text: qsTr("Развлечения")
                            }

                            TextSwitch
                            {
                                   id:switchSport
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          right: parent.right
                                   }
                                   text: qsTr("Спорт")
                            }

                            TextSwitch
                            {
                                   id:switchFamily
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          right: parent.right
                                   }
                                   text: qsTr("Семья")
                            }

                            TextField
                            {
                                   id:textFieldOther
                                   anchors {
                                          left: parent.left
                                          right: parent.right
                                   }
                                   placeholderText: qsTr("Другое")
                            }
                     }

                     Rectangle
                     {
                            id: _spacer_2
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 10
                            color: "lightgreen"
                     }

                     Rectangle
                     {
                            id: _rec
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 450
                            color: "#2c3e50"

                            Label {
                                   id: _txt_mailing
                                   objectName: "mailingText"
                                   anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                                   color: palette.highlightColor
                                   font.pixelSize: Theme.fontSizeSmall
                                   textFormat: Text.RichText
                                   wrapMode: Text.WordWrap
                                   text: qsTr("Согласие на рассылку информации от партнёров сервиса")
                            }

                            TextSwitch
                            {
                                   id:switchMailing
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          top: _txt_mailing.bottom
                                          leftMargin: Theme.horizontalPageMargin
                                          rightMargin: Theme.horizontalPageMargin
                                          topMargin: Theme.paddingLarge
                                   }

                                   text: checked ? qsTr("Согласен"): qsTr("Не согласен")
                            }

                            Label {
                                   id: _txt_approval
                                   objectName: "approvalText"
                                   anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin ;top: switchMailing.bottom}
                                   color: palette.highlightColor
                                   font.pixelSize: Theme.fontSizeSmall
                                   textFormat: Text.RichText
                                   wrapMode: Text.WordWrap
                                   text: qsTr("Согласие на обработку персональных данных")
                            }

                            TextSwitch
                            {
                                   id:switchPersonalData
                                   checked: true
                                   anchors {
                                          left: parent.left
                                          top: _txt_approval.bottom
                                          leftMargin: Theme.horizontalPageMargin
                                          rightMargin: Theme.horizontalPageMargin
                                          topMargin: Theme.paddingLarge
                                   }
                                   text: checked ? qsTr("Согласен"): qsTr("Не согласен")
                            }
                     }

                     Rectangle
                     {
                            id: _spacer_3
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 10
                            color: "lightgreen"
                     }

                     Item
                     {
                            anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                            height: 170
                     }

                     Button
                     {
                            id: _pbn_applay
                            anchors {
                                   horizontalCenter: parent.horizontalCenter
                                   top: switchPersonalData.bottom
                                   bottomMargin: Theme.paddingLarge
                            }
                            text: qsTr("Применить")
                            width: parent.width * 0.75
                            height: implicitHeight
                            onClicked: {
                                   showUserData()

                                   if(textField_passwordReplay.text!=textField_password.text)
                                   {

                                          return
                                   }

                                   myPassword= textField_passwordReplay.text
                                   myEmail=textField_Email.text
                                   myName= textField_Name.text
                                   mySecondName=textField_SecondName.text
                                   myFamilyName=textField_Family.text
                                   myEducation=switchEducation.checked
                                     myEntertainment=switchEntertainment.checked
                                      mySport=switchSport.checked
                                      myFamily=switchFamily.checked
                                      myFieldOther=textFieldOther.text
                                       myMailing=switchMailing.checked
                                     myPersonalData=switchPersonalData.checked

                                   pageStack.push(Qt.resolvedUrl("MainPage.qml"))
                            }
                     }
              }
              VerticalScrollDecorator{}
       }

       Connections {
              target: switchPersonalData
              onCheckedChanged: {
                     switchPersonalData.checked? _pbn_applay.visible=true: _pbn_applay.visible=false
              }
       }

       /**
        * @brief Вывод информации о пользователе.
        */
       function showUserData()
       {
              console.log("Фамилия",textField_Family.text)
              console.log("Имя",textField_Name.text)
              console.log("Отчество",textField_SecondName.text)
              console.log("Электронная почта: ",textField_Email.text)
              console.log("Интересы:")
              console.log("Образование",switchEducation.checked)
              console.log("Развлечения",switchEntertainment.checked)
              console.log("Спорт",switchSport.checked)
              console.log("Семья",switchFamily.checked)
              console.log("Другое",textFieldOther.text)
              console.log("Согласие на рассылку от партнёров сервиса",switchMailing.checked)
              console.log("Согласие на обработку персональных данных",switchPersonalData.checked)
       }

       Component.onCompleted:
       {target:page

              textField_password.text=myPassword
              textField_passwordReplay.text=myPassword
              textField_Email.text=myEmail
              textField_Name.text=myName
              textField_SecondName.text=mySecondName
              textField_Family.text=myFamilyName

              switchEducation.checked=myEducation
               switchEntertainment.checked= myEntertainment
                 switchSport.checked=mySport
                 switchFamily.checked=myFamily
                 textFieldOther.text=myFieldOther
                  switchMailing.checked=myMailing
              switchPersonalData.checked=myPersonalData
       }
}

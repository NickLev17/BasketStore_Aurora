TARGET = ru.template.BasketStore
QT += sql
CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    database.cpp \
    src/main.cpp \
    storemanager.cpp

HEADERS += \
    database.h \
    storemanager.h

DISTFILES += \
    qml/icons/arrowDown.png \
    rpm/ru.template.BasketStore.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.template.BasketStore.ts \
    translations/ru.template.BasketStore-ru.ts \

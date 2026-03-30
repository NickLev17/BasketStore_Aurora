#include <QtQuick>
#include <auroraapp.h>
#include "storemanager.h"
#include "database.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<StoreManager>("storemanager",1,0,"StoreManager");
    qmlRegisterType<Database>("Database", 1, 0, "Database");
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.template"));
    application->setApplicationName(QStringLiteral("BasketStore"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/BasketStore.qml")));
    view->show();

    return application->exec();
}

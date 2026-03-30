#ifndef STOREMANAGER_H
#define STOREMANAGER_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QVariantMap>
#include <QString>
#include <QMap>
#include <QUrl>

/**
 * @brief class StoreManager
 * Предоставлет возможность сетевого взаимодействия с интерент ресурсом.
 * С API тестового интернет магазина.
 */
class StoreManager : public QObject
{
    Q_OBJECT
public:

    /**
     * @brief Конструктор класса StoreManager.
     * Базовый конструктор по умолчанию.
    *  */
    explicit StoreManager(QObject *parent = nullptr);

    /**
     * Свойство state отвечает за текущее состояние сетевого подключения.
     */
    Q_PROPERTY(bool state WRITE setState READ state NOTIFY onStateChanged);

    /**
     * @brief Показ данных пользователю в режиме отладки.
     * Отвечает за вывод информации пользователю в режиме отлдки.
    *  */
    void showData(const QVariantMap& allObjwcts);

    /**
     * @brief Начальная инициализация и вызов метода для загрузки данных.
     * Отвечает за вызов метода для загрузки данных.
     * @details Вызывается из QML для получения данных и их последующей обработки.
     *  */
    Q_INVOKABLE void initialisation();

    /**
     * @brief Получение данных с интернет ресурса и их обработка.
     * Отвечает за загрузку данных с интернет ресурса в локальные переменные и их дальнейшую обработку.
     * @param path - электронный адрес ресурса.
     * @details Вызывается из QML для получения данных и их последующей обработки.
     *  */
    Q_INVOKABLE void loadStoreData(const QUrl& path);

    /**
     * @brief Вовзрат всех товаров.
     * Отвечает за вовзрат всех обьектов товаров полученных с интернет ресурса
     * @return QVariantMap - данный с интернет ресурса. Тестовые сведения о товарах.
     * @details Вызывается из QML для получения данных и их последующей обработки.
     *  */
    Q_INVOKABLE QVariantMap getAllObjects()const;




    /**
     * @brief Установка состояния.
     * Отвечает установку состояния.
    *  */

    /**
     * @brief Возврат переменной состояния.
     * Отвечает возврат значения переменной состояния.
    *  */
    bool state() const;

    /**
     * @brief Показ данных пользователю в режиме отладки.
     * Отвечает за вывод информации пользователю в режиме отлдки.
    *  */
    void setState(bool state);

    /**
     * Переменная состояния загрузки данных.
     */
    bool m_stateLoad;

    /**
     * Обьект сетевого менеджера.
     */
    QNetworkAccessManager networkManager;

    /**
     * Контейнер для хранения данных о всех товарах.
     */
    QVariantMap  m_allObjects;

signals:

    /**
     * @brief Сигнал изменения состояния получения данных с интернет ресурса.
     * Отвечает за выпуск сигнала о смене состояния получения данных.
     *  */
    void onStateChanged();

};

#endif // STOREMANAGER_H




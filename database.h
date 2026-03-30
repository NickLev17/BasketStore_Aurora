#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariantMap>
#include <QVariantList>

/**
 * @brief class Database
 * Предоставлет возможность взаимодействи с базой данных SQLite.
 *
 */
class Database : public QObject {

    Q_OBJECT

    /**
     * Свойство connected отвечает за текущее состояние подключения.
     */
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)

public:
    /**
     * @brief Базовый конструктор класса.
     * Конструктор по умолчанию.
    *  */
    explicit Database(QObject *parent = nullptr);

    /**
     * @brief Метод для соедиенения с базой данных.
     * Отвечает за создание покдлючения к базе данных.
     * @return true если подключение произошло успешно, иначе false.
    * @details Вызывается из QML для подключения к БД.
    *  */
    Q_INVOKABLE bool connect();

    /**
     * @brief Метод для разрыва соедиенения с базой данных.
     * Отвечает за разрыв покдлючения с базой данных.
     * @return true если отключение произошло успешно, иначе false.
    * @details Вызывается из QML для подключения к БД.
    *  */
    Q_INVOKABLE bool disconnect();

    /**
     * @brief Создание и открытие таблицы базы данных.
     * Отвечает за создание таблицы в базе данных, проверка ее наличия.
     * @param tableName - имя таблицы, которую нужно создать или открыть.
     * @return true если создание таблицы произошло успешно, иначе false.
    * @details Вызывается из QML для создания/открытия таблицы из базы данных.
    *  */
    Q_INVOKABLE bool createTable(const QString &tableName);

    /**
     * @brief Метод получения текущего значения соединения с базой данных.
     * Отвечает за вовзарт значения состояния соединения с базой данных.
     * @return true если отключение произошло успешно, иначе false.
    * @details Вызывается из QML для подключения к БД.
    *  */
    Q_INVOKABLE bool stateConnect() const;

    /**
     * @brief Добавление данных в таблицу
     * Отвечает за добавление данных в таблицу базы данных.
     * @param tableName - имя таблицы, которую нужно создать или открыть.
     *  @param title - название товара.
     *  @param price - стоимость товара.
     *  @param image - изображение товара.
     *  @param caegory - категория товара.
     *  @param description - описание товара.
     *  @param rate - рейтинг товара.
     *  @param voices - количество отметок пользователей.
     * @return true если запрос выполнен успешно, иначе false.
    * @details Вызывается из QML для создания/открытия таблицы из базы данных.
    *  */
    Q_INVOKABLE bool addRecord(const QString& tableName,const QString &title,const double &price, const QString &image, const QString &category, const QString &description,const double &rate,const double &voices);

    /**
     * @brief Чтение данных из таблицы базы данных.
     * Отвечает за чтение данных из таблицы.
     * @param tableName - имя таблицы, которую нужно создать или открыть.
     * @details Вызывается из QML для чтения данных из таблицы базы данных.
     *  */
    Q_INVOKABLE void readTableData(const QString &tableName);


    /**
     * @brief Получение данных из таблицы
     * Отвечает за вовзрат данных из таблицы базы данных.
     * @param tableName - имя таблицы, данные из которой нужно вернуть.
     * @return Данные в формате QVariantMap.
     * @details Вызывается из QML для получения данных и их последующей обработки.
     *  */
    Q_INVOKABLE QVariantMap getTableData(const QString &tableName);

    /**
     * @brief Удаление записи из таблицы.
     * Отвечает за удаление данных из таблицы базы данных.
     * @param tableName - имя таблицы, данные из которой нужно удалить.
     * @param value - значение по которому осуществляется удаление.
     * @return true если запрос выполнен успешно, иначе false.
     * @details Вызывается из QML для удаления записи из таблицы базы данных.
     *  */
    Q_INVOKABLE bool removeRowTable(const QString& tableName,const QString& value);



    /**
     * @brief Удаление всех записей из таблицы.
     * Отвечает за удаление всех данных из таблицы базы данных.
     * @param tableName - имя таблицы, данные из которой нужно удалить.
     * @return true если запрос выполнен успешно, иначе false.
     * @details Вызывается из QML для удаления записи из таблицы базы данных.
     *  */
    Q_INVOKABLE bool removeTableDatabase(const QString& tableName);

    /**
     * @brief Получение отсортированных данных из таблицы
     * Отвечает за вовзрат отсортированных данных из таблицы базы данных.
     * Сортировка осуществляется в соответсвии с выбранным пользователем критерием.
     * @param tableName - имя таблицы, данные из которой нужно вернуть.
     * @param pattern - критерий ростировки ASC или DESC, по возрастанию или убыванию соответственно.
     * @return Данные в формате QVariantMap.
     * @details Вызывается из QML для получения данных и их последующей обработки.
     *  */
    Q_INVOKABLE QVariantMap sortDataTable(const QString& tableName,const QString& pattern);

    /**
     * @brief Получение данных о текущем состоянии соединения.
     * Отвечает за получение данных о состоянии соединения.
     * @return true если состояние подключения активно, иначе false.
     *  */
    bool connected() const { return m_connected; }

signals:

    /**
     * @brief Сигнал изменения состояния подключения
     * Отвечает за выпуск сигнала о смене состояния покдлючения.
     *  */
    void connectedChanged();

private:

    /**
     * Обьект базы данных.
     */
    QSqlDatabase m_db;

    /**
     * Переменна, характеризующая состояние подключения к базе данных.
     */
    bool m_connected = false;
};

#endif

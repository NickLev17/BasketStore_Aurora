#include "database.h"
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QVariantMap>
#include <QSqlQuery>
#include <QSqlRecord>
Database::Database(QObject *parent) : QObject(parent) {}

bool Database::connect() {

    QString dbPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/mydb.sqlite";

    QDir dir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    if (!dir.exists()) dir.mkpath(".");

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(dbPath);

    if (m_db.open()) {
        m_connected = true;
        emit connectedChanged();
        qDebug() << "Подключено к БД:" << dbPath;
        return true;
    } else {
        qDebug() << "Ошибка:" << m_db.lastError().text();
        return false;
    }
}

bool Database::createTable(const QString &tableName) {
    if (!m_connected) return false;

    QSqlQuery query;
    QString sql = QString("CREATE TABLE IF NOT EXISTS %1 (id INTEGER PRIMARY KEY AUTOINCREMENT,Title TEXT,\
                          Price REAL CHECK(Price >= 0) CHECK(Price <= 999999.99),\
                          Image TEXT(500),          \
                          Category TEXT(100),\
                          Description TEXT(1000) ,\
                          Rate REAL CHECK(Rate >= 0) CHECK(Rate <= 999999.99),\
                          Voices REAL CHECK(Voices >= 0) CHECK(Voices <= 999999.99)\
                          )").arg(tableName);

        if (query.exec(sql)) {
        qDebug() << "Таблица создана:" << tableName;
        return true;
    }
    qDebug() << "Ошибка таблицы:" << query.lastError().text();
    return false;
}

bool Database::addRecord(const QString& tableName,const QString &title,const double &price, const QString &image, const QString &category, const QString &description,const double &rate,const double &voices) {

    if (!m_connected) return false;

    QSqlQuery query;
    query.prepare("INSERT INTO "+tableName+" (Title,Price,Image,Category,Description,Rate,Voices) VALUES (?,?,?,?,?,?,?)");
    query.addBindValue(title);
    query.addBindValue(price);
    query.addBindValue(image);
    query.addBindValue(category);
    query.addBindValue(description);
    query.addBindValue(rate);
    query.addBindValue(voices);
    return query.exec();
}

void Database::readTableData(const QString &tableName) {
    if (!m_connected) {
        qDebug() << "БД не подключена!";
        return;
    }

    QSqlQuery query;
    query.exec("SELECT * FROM " + tableName);

    qDebug() << "ДАННЫЕ ИЗ ТАБЛИЦЫ" << tableName << "===";
    while (query.next()) {
        int id = query.value("id").toInt();
        QString title = query.value("Title").toString();
        double price = query.value("Price").toDouble();
        QString image = query.value("Image").toString();
        QString category = query.value("Category").toString();
        QString description = query.value("Description").toString();
        double rate = query.value("Rate").toDouble();
        double voices = query.value("Voices").toDouble();

        qDebug() << "ID:" << id << "| Title:" << title <<"| price| "<<price<< "| image:" << image<< "| category:" << category<< "| description:" << description<<" | rate "<<rate<<" | voices "<<voices;
    }

    qDebug() << "Чтение завершено, записей в БД ";
}

QVariantMap Database::getTableData(const QString &tableName) {
    if (!m_connected) {
        qDebug() << "БД не подключена!";
        return QVariantMap();
    }

    QSqlQuery query;
    query.exec("SELECT * FROM " + tableName);

    qDebug() << "ДАННЫЕ ИЗ ТАБЛИЦЫ" << tableName << "===";
    QVariantMap allProducts;
    allProducts.clear();

    int cur=0;
    while (query.next()) {
        QVariantMap currentProduct;
        currentProduct.clear();
        currentProduct.insert("Id", query.value("id").toInt());
        currentProduct.insert("Title", query.value("Title").toString());
        currentProduct.insert("Price", query.value("Price").toDouble());
        currentProduct.insert("Image",query.value("Image").toString());
        currentProduct.insert("Category", query.value("Category").toString());
        currentProduct.insert("Description",query.value("Description").toString());
        currentProduct.insert("Rate", query.value("Rate").toDouble());
        currentProduct.insert("Voices", query.value("Voices").toDouble());
        cur++;
        allProducts.insert(QString::number(cur),currentProduct);
        qDebug()<<" Data is get DATABASE";

    }
    qDebug() << "Чтение завершено "<<allProducts.size();
    return allProducts;
}

bool Database::removeRowTable(const QString &tableName, const QString& value)
{
    QSqlQuery query;
    query.prepare("DELETE FROM " + tableName +
                  " WHERE id = (SELECT MAX(id) FROM " + tableName + " WHERE LOWER(Title) = LOWER(:value))");
    query.bindValue(":value", value);
    bool success = query.exec();
    m_db.commit();

    if (!success) {
        qDebug() << "Ошибка удаления последней строки:" << query.lastError().text();
    } else {
        qDebug() << "Удалено строк:" << query.numRowsAffected();
        qDebug() << "Данные удалены успешно (последняя)" << value;
    }
    return success;
}

bool Database::stateConnect() const
{
    return m_connected;
}

bool Database::disconnect()
{
    if (m_db.open()) {
        m_connected = false;
        m_db.close();
        qDebug() << "БД ОТКЛЮЧЕНА:";
        return true;
    } else {
        m_connected = false;
        return true;
    }
}

bool Database::removeTableDatabase(const QString &tableName)
{
    QSqlQuery query;
    query.exec("DELETE FROM " + tableName);
    return query.exec();
}

QVariantMap Database::sortDataTable(const QString &tableName,const QString& pattern)
{
    QSqlQuery query;
    query.exec( "SELECT * FROM "+ tableName +" ORDER BY Price "+pattern+";");
    QVariantMap allProducts;
    allProducts.clear();

    int cur=0;
    while (query.next()) {
        QVariantMap currentProduct;
        currentProduct.clear();
        currentProduct.insert("Id", query.value("id").toInt());
        currentProduct.insert("Title", query.value("Title").toString());
        currentProduct.insert("Price", query.value("Price").toDouble());
        currentProduct.insert("Image",query.value("Image").toString());
        currentProduct.insert("Category", query.value("Category").toString());
        currentProduct.insert("Description",query.value("Description").toString());
        currentProduct.insert("Rate", query.value("Rate").toDouble());
        currentProduct.insert("Voices", query.value("Voices").toDouble());
        cur++;
        allProducts.insert(QString::number(cur),currentProduct);
        qDebug()<<" Data is get DATABASE";

    }
    qDebug() << "Чтение завершено "<<allProducts.size();
    return allProducts;
}



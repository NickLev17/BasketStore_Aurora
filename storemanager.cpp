#include "storemanager.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QDebug>
#include "storemanager.h"
#include <QVariantMap>

StoreManager::StoreManager(QObject *parent) : QObject(parent)
{
    m_stateLoad=false;
}

void StoreManager::showData(const QVariantMap &allObjwcts)
{
    if(allObjwcts.isEmpty())
    {
        return;
    }

    for( auto it=m_allObjects.begin();it!=m_allObjects.end();++it)
    {
        QVariantMap tmp;
        tmp.clear();
        tmp.insert("1",*it);
        for(auto it2=tmp.begin();it2!=tmp.end();++it2)
        {
            qDebug()<<it2.value();
        }
        qDebug()<<"-----------------";
    }
}

void StoreManager::initialisation()
{
    QUrl apiUrl("https://fakestoreapi.com/products");
    loadStoreData(apiUrl);
}

void StoreManager::loadStoreData(const QUrl &path)
{
    if(path.isEmpty())
    {
        setProperty("state",QVariant(false));
        return;
    }
    m_allObjects.clear();

    QNetworkRequest request(path);
    QNetworkReply* reply = networkManager.get(request);

    QObject::connect(reply, &QNetworkReply::finished, [=]() mutable {
        if (reply->error() != QNetworkReply::NoError) {
            qDebug() << "Network error:" << reply->errorString();
            reply->deleteLater();
            return;
        }

        QByteArray responseBody = reply->readAll();
        QJsonDocument jsonResponse = QJsonDocument::fromJson(responseBody);

        if (jsonResponse.isNull()) {
            qDebug() << "JSON parsing failed.";
        } else {

            if (jsonResponse.isArray()) {

                QJsonArray products = jsonResponse.array();
                QJsonObject obj=products.at(0).toObject();
                qDebug()<<obj.keys();
                foreach(const QJsonValue &productValue, products) {
                    QVariantMap tmp;
                    tmp.clear();
                    if(productValue.isObject()) {
                        QJsonObject product = productValue.toObject();


                        qDebug() << "Product ID:" << product["id"].toInt()
                                 << ", Title:" << product["title"].toString()
                                 << ", Category:" << product["category"].toString()
                                 << ", Description:" << product["description"].toString()
                                 << ", Price:" << product["price"].toDouble()
                                 << ", Image:" << product["image"].toString();

                        tmp.insert("Title",product["title"].toString());
                        tmp.insert("Product ID",product["id"].toInt());
                        tmp.insert("Price",product["price"].toDouble());
                        tmp.insert("Image",product["image"].toString());
                        tmp.insert("Category",product["category"].toString());
                        tmp.insert("Description",product["description"].toString());

                        if (product["rating"].isObject()) {
                            QJsonObject ratingObj = product["rating"].toObject();

                            for (auto it = ratingObj.begin(); it != ratingObj.end(); ++it) {
                                QString key = it.key();
                                QJsonValue value = it.value();

                                if(key=="rate")
                                {  tmp.insert("Rate",value.toDouble());}

                                if(key=="count")
                                {
                                    tmp.insert("Voices",value.toDouble());
                                }
                                qDebug() << "KEY:" << key << "VALUE:" << value.toDouble();
                            }
                        }
                    }
                    m_allObjects.insert(tmp.find("Title").value().toString(),tmp);
                }
                qDebug()<<"Get State "<<property("state").toBool();
            } else {
                qDebug() << "Unexpected JSON format!";
            }
        }

        reply->deleteLater();
        qDebug()<<"---------------------------------";
        qDebug()<<m_allObjects.size();
        showData(getAllObjects());
    });
    setProperty("state",QVariant(true));
}

QVariantMap StoreManager::getAllObjects() const
{
    return m_allObjects;
}

bool StoreManager::state() const
{
    return m_stateLoad;
}

void StoreManager::setState(bool state)
{
    m_stateLoad=state;
    qDebug()<<"State = "<<m_stateLoad;
    onStateChanged();
}

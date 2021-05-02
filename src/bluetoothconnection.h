/*
 * SPDX-FileCopyrightText: 2021 Daniel Vrátil <me@dvratil.cz>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#ifndef BLUETOOTHCONNECTION_H
#define BLUETOOTHCONNECTION_H

#include <QObject>
#include <QBluetoothSocket>

class BluetoothConnection : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString deviceAddress READ deviceAddress WRITE setDeviceAddress NOTIFY deviceAddressChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)

public:
    explicit BluetoothConnection(QObject *parent = nullptr);
    ~BluetoothConnection() override;

    void setDeviceAddress(const QString &address);
    QString deviceAddress() const;

    bool connected() const;

public Q_SLOTS:
    void sendData(const QString &data);
    void disconnectFromService();

Q_SIGNALS:
    void deviceAddressChanged();
    void connectedChanged();
    void connectionError(int code, const QString &message);

    void newData(const QString &data);

private Q_SLOTS:
    void socketStateChanged(QBluetoothSocket::SocketState state);
    void socketError(QBluetoothSocket::SocketError error);
    void socketReadyRead();

private:
    QBluetoothSocket mSocket;
};

#endif // BLUETOOTHCONNECTION_H

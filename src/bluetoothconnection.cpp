#include "bluetoothconnection.h"

#include <QBluetoothAddress>
#include <QBluetoothUuid>

namespace {

const QString serviceUuid{QStringLiteral("00001101-0000-1000-8000-00805f9b34fb")};

}

BluetoothConnection::BluetoothConnection(QObject *parent)
    : QObject(parent)
    , mSocket(QBluetoothServiceInfo::RfcommProtocol)
{
    connect(&mSocket, &QBluetoothSocket::stateChanged, this, &BluetoothConnection::socketStateChanged);
    connect(&mSocket, qOverload<QBluetoothSocket::SocketError>(&QBluetoothSocket::error), this, &BluetoothConnection::socketError);
    connect(&mSocket, &QBluetoothSocket::readyRead, this, &BluetoothConnection::socketReadyRead);
}

BluetoothConnection::~BluetoothConnection()
{
    qDebug() << "Bluetooth connection destroyed.";
}

void BluetoothConnection::setDeviceAddress(const QString &address)
{
    const QBluetoothAddress addr{address};
    if (addr == mSocket.peerAddress()) {
        return;
    }

    if (mSocket.state() != QBluetoothSocket::UnconnectedState) {
        mSocket.disconnectFromService();
    }

    qDebug() << "Connecting to" << addr.toString();
    mSocket.connectToService(addr, QBluetoothUuid{serviceUuid});
    Q_EMIT deviceAddressChanged();
}

void BluetoothConnection::disconnectFromService()
{
    mSocket.disconnectFromService();
}

QString BluetoothConnection::deviceAddress() const
{
    return mSocket.peerAddress().toString();
}

bool BluetoothConnection::connected() const
{
    return mSocket.state() == QBluetoothSocket::ConnectedState;
}

void BluetoothConnection::sendData(const QString &data)
{
    if (!connected()) {
        qWarning() << "Cannot send data: socket not connected";
        return;
    }

    mSocket.write(data.toUtf8());
}

void BluetoothConnection::socketStateChanged(QBluetoothSocket::SocketState state)
{
    qDebug() << "Bluetooth socket entered" << state;
    Q_EMIT connectedChanged();
}

void BluetoothConnection::socketError(QBluetoothSocket::SocketError error)
{
    qWarning() << "Bluetooth socket error: " << error << "(" << mSocket.errorString() << ")";
    Q_EMIT connectionError(error, mSocket.errorString());
}

void BluetoothConnection::socketReadyRead()
{
    const auto data = mSocket.readAll();
    if (!data.isEmpty()) {
        Q_EMIT newData(QString::fromUtf8(data));
    }
}

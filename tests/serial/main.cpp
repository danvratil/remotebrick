#include <QCoreApplication>
#include <QBluetoothSocket>
#include <QBluetoothAddress>

const QBluetoothAddress device{QStringLiteral("00:20:04:BD:42:A2")};
const QString serviceUuid{QStringLiteral("00001101-0000-1000-8000-00805f9b34fb")};

int main(int argc, char **argv) {
    QCoreApplication app(argc, argv);

    QBluetoothSocket btSock(QBluetoothServiceInfo::RfcommProtocol);
    btSock.connectToService(device, QBluetoothUuid{serviceUuid});

    return app.exec();
}

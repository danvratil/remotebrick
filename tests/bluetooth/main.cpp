#include <QCoreApplication>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothSocket>
#include <QBluetoothServiceDiscoveryAgent>
#include <QBluetoothAddress>
#include <QBluetoothLocalDevice>
#include <QTimer>

#include <iostream>

namespace {

QMap<QBluetoothAddress, QBluetoothDeviceInfo> devices;

std::unique_ptr<QBluetoothLocalDevice> localDevice;
std::unique_ptr<QBluetoothSocket> socket;

const QString serviceUuid = QStringLiteral("00001101-0000-1000-8000-00805F9B34FB");

}

std::ostream &operator<<(std::ostream &str, const QString &s) {
    return str << qUtf8Printable(s);
}

void deviceSocketConnected() {
    std::cout << "Socket connection to device " << socket->peerAddress().toString() << " established" << std::endl;
}

void deviceSocketError(QBluetoothSocket::SocketError error) {
    std::cerr << "Device socket error: " << error << std::endl;
    exit(1);
}

void deviceSocketStateChanged(QBluetoothSocket::SocketState state) {
    std::cout << "Device socket state:" << state << std::endl;
}

void deviceSocketData() {
    std::cout << "< " << socket->readAll().constData() << std::endl;
}

void connectToDevice(const QBluetoothDeviceInfo &device) {
    switch (localDevice->pairingStatus(device.address())) {
    case QBluetoothLocalDevice::Unpaired:
        std::cout << "Device " + device.address().toString() << " not paired, requesting pairing." << std::endl;
        // FIXME: This doesn't work on desktop, because Qt doesn't have API to specify custom
        // pairing PIN.
        localDevice->requestPairing(device.address(), QBluetoothLocalDevice::Paired);
        return;
    case QBluetoothLocalDevice::Paired:
    case QBluetoothLocalDevice::AuthorizedPaired:
        std::cout << "Device " + device.address().toString() << " aready paired, connecting." << std::endl;
        break;
    }

    socket = std::make_unique<QBluetoothSocket>(QBluetoothServiceInfo::RfcommProtocol);
    QObject::connect(socket.get(), &QBluetoothSocket::connected, deviceSocketConnected);
    QObject::connect(socket.get(), &QBluetoothSocket::stateChanged, deviceSocketStateChanged);
    QObject::connect(socket.get(), qOverload<QBluetoothSocket::SocketError>(&QBluetoothSocket::error), deviceSocketError);
    QObject::connect(socket.get(), &QBluetoothSocket::readyRead, deviceSocketData);
    socket->connectToService(device.address(), QBluetoothUuid{serviceUuid});
}

void selectDevice() {
    std::cout << std::endl << "Select device to connect to:" << std::endl;
    int i = 1;
    for (auto it = devices.cbegin(), end = devices.cend(); it != end; ++it, ++i) {
        const auto name = QStringLiteral("%1 (%2)").arg(it->name(), it->address().toString());
        std::cout << "[" << i << "] " << name << std::endl;
    }

    int option = 0;
    std::cout << "> ";
    std::cin >> option;

    if (option == 0 || option > devices.size()) {
        std::cerr << "Invalid input." << std::endl;
        exit(1);
    }

    connectToDevice(*(devices.begin() + (option - 1)));
}

void deviceDiscovered(const QBluetoothDeviceInfo &device) {
    std::cout << "Device " << device.address().toString() << " discovered" << std::endl;
    devices.insert(device.address(), device);
}

void deviceUpdated(const QBluetoothDeviceInfo &device) {
    devices.insert(device.address(), device);
}

void deviceDiscoveryError(QBluetoothDeviceDiscoveryAgent::Error error) {
    std::cerr << "Error during device discovery: " + std::to_string(error) << std::endl;
    exit(1);
}

void deviceDiscoverFinished() {
    std::cout << "Device discovery finished." << std::endl;

    selectDevice();
}

void deviceConnected(const QBluetoothAddress &device) {
    std::cout << "Connection with device " << device.toString() << " established." << std::endl;
}

void deviceDisconnected(const QBluetoothAddress &device) {
    std::cout << "Connection with device " << device.toString() << " lost." << std::endl;
    exit(0);
}

void deviceError(QBluetoothLocalDevice::Error error) {
    std::cout << "Device error: " << error << std::endl;
    exit(1);
}

void confirmDevicePairing(const QBluetoothAddress &device, const QString &pin) {
    std::cout << "Confirming device PIN " << pin << std::endl;
    localDevice->pairingConfirmation(true);
}

void devicePairingFinished(const QBluetoothAddress &device) {
    std::cout << "Pairing with device " + device.toString() << " finished." << std::endl;
}

int main(int argc, char **argv) {
    QCoreApplication app(argc, argv);

    const auto localDevices = QBluetoothLocalDevice::allDevices();
    if (localDevices.empty()) {
        std::cerr << "No local Bluetooth devices found!" << std::endl;
        exit(1);
    }

    localDevice = std::make_unique<QBluetoothLocalDevice>(localDevices.front().address());
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::deviceConnected, deviceConnected);
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::deviceDisconnected, deviceDisconnected);
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::error, deviceError);
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::pairingDisplayConfirmation, confirmDevicePairing);
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::pairingDisplayPinCode, confirmDevicePairing);
    QObject::connect(localDevice.get(), &QBluetoothLocalDevice::pairingFinished, devicePairingFinished);

    QBluetoothDeviceDiscoveryAgent deviceDiscovery;
    QObject::connect(&deviceDiscovery, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered, deviceDiscovered);
    QObject::connect(&deviceDiscovery, &QBluetoothDeviceDiscoveryAgent::deviceUpdated, deviceUpdated);
    QObject::connect(&deviceDiscovery, qOverload<QBluetoothDeviceDiscoveryAgent::Error>(&QBluetoothDeviceDiscoveryAgent::error), deviceDiscoveryError);
    QObject::connect(&deviceDiscovery, &QBluetoothDeviceDiscoveryAgent::finished, deviceDiscoverFinished);

    std::cout << "Discovering devices..." << std::endl;
    QTimer::singleShot(0, &app, [&deviceDiscovery]() { deviceDiscovery.start(); });
    app.exec();
    return 0;
}

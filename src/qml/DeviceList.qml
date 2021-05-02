import QtQuick 2.4
import QtQuick.Controls 2.12
import QtBluetooth 5.12

DeviceListForm {

    loading: deviceDiscoveryModel.running

    deviceModel: BluetoothDiscoveryModel {
        id: deviceDiscoveryModel
        discoveryMode: BluetoothDiscoveryModel.DeviceDiscovery
        running: true

        onRunningChanged: {
            if (running) {
                console.log("Device discovery started");
            } else {
                console.log("Device discovery stopped");
            }
        }

        onDeviceDiscovered: console.log("Device discovered: " + device)

        onErrorChanged: {
            console.log("Device discovery error: " + error)
            if (error === BluetoothDiscoveryModel.PoweredOffError) {
                toaster.show(qsTr("Bluetooth is turned off, please turn it on."));
            } else if (error == BluetoothDiscoveryModel.InputOutputError) {
                toaster.show(qsTr("I/O Error during discovery."));
            } else {
                toaster.show(qsTr("Failed to scan devices."));
            }
        }
    }

    toolButton.onClicked: deviceDiscoveryModel.running = !deviceDiscoveryModel.running

    deviceDelegate: ItemDelegate {
        width: parent.width
        text: model.name
        icon.name: "network-bluetooth"

        onClicked: deviceSelected(model.name, model.remoteAddress);
    }

    function deviceSelected(name, address) {
        deviceDiscoveryModel.running = false
        stackView.push(devicePage, {"deviceName": name, "deviceAddress": address})
    }

    Component {
        id: devicePage

        DevicePage {}
    }
}

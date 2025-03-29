import 'package:flutter/material.dart';

class DeviceControlScreen extends StatefulWidget {
  const DeviceControlScreen({super.key});

  @override
  State<DeviceControlScreen> createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  final List<Device> _devices = [
    Device(name: 'Living Room AC', icon: Icons.ac_unit, isOn: false, watts: 1500),
    Device(name: 'Bedroom AC', icon: Icons.ac_unit, isOn: false, watts: 1200),
    Device(name: 'TV', icon: Icons.tv, isOn: false, watts: 100),
    Device(name: 'Living Room Fan', icon: Icons.wind_power, isOn: false, watts: 75),
    Device(name: 'Bedroom Fan', icon: Icons.wind_power, isOn: false, watts: 75),
    Device(name: 'Kitchen Lights', icon: Icons.lightbulb_outline, isOn: false, watts: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Control'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(
                device.icon,
                color: device.isOn
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                size: 32,
              ),
              title: Text(
                device.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${device.watts}W',
                style: TextStyle(
                  color: device.isOn
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
              ),
              trailing: Switch(
                value: device.isOn,
                onChanged: (value) {
                  setState(() {
                    device.isOn = value;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Device {
  final String name;
  final IconData icon;
  final int watts;
  bool isOn;

  Device({
    required this.name,
    required this.icon,
    required this.isOn,
    required this.watts,
  });
}

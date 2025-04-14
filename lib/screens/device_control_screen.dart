import 'package:flutter/material.dart';

class DeviceControlScreen extends StatefulWidget {
  const DeviceControlScreen({super.key});

  @override
  State<DeviceControlScreen> createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  final List<Device> _devices = [
    Device(
      name: 'Living Room AC',
      icon: Icons.ac_unit,
      isOn: false,
      watts: 1500,
      category: DeviceCategory.cooling,
    ),
    Device(
      name: 'Bedroom AC',
      icon: Icons.ac_unit,
      isOn: false,
      watts: 1200,
      category: DeviceCategory.cooling,
    ),
    Device(
      name: 'Smart TV',
      icon: Icons.tv,
      isOn: false,
      watts: 100,
      category: DeviceCategory.entertainment,
    ),
    Device(
      name: 'Living Room Fan',
      icon: Icons.wind_power,
      isOn: false,
      watts: 75,
      category: DeviceCategory.cooling,
    ),
    Device(
      name: 'Bedroom Fan',
      icon: Icons.wind_power,
      isOn: false,
      watts: 75,
      category: DeviceCategory.cooling,
    ),
    Device(
      name: 'Kitchen Lights',
      icon: Icons.lightbulb_outline,
      isOn: false,
      watts: 40,
      category: DeviceCategory.lighting,
    ),
  ];

  void _addNewDevice() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddDeviceSheet(
        onAdd: (device) {
          setState(() {
            _devices.add(device);
          });
        },
      ),
    );
  }

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
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: device.category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      device.icon,
                      color: device.isOn ? device.category.color : Colors.grey,
                      size: 32,
                    ),
                  ),
                  title: Text(
                    device.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        device.category.label,
                        style: TextStyle(
                          color: device.category.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                if (device.isOn)
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.electric_bolt,
                                  color: device.category.color,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${device.watts}W',
                                  style: TextStyle(
                                    color: device.category.color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Est. ₹${(device.watts * 0.008).toStringAsFixed(2)}/hr',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDevice,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddDeviceSheet extends StatefulWidget {
  final Function(Device) onAdd;

  const _AddDeviceSheet({required this.onAdd});

  @override
  State<_AddDeviceSheet> createState() => _AddDeviceSheetState();
}

class _AddDeviceSheetState extends State<_AddDeviceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _wattsController = TextEditingController();
  DeviceCategory _selectedCategory = DeviceCategory.other;

  @override
  void dispose() {
    _nameController.dispose();
    _wattsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Device',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Device Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a device name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _wattsController,
              decoration: const InputDecoration(
                labelText: 'Power Consumption (Watts)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter power consumption';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DeviceCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: DeviceCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: [
                      Icon(category.icon, color: category.color),
                      const SizedBox(width: 8),
                      Text(category.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final device = Device(
                    name: _nameController.text,
                    icon: _selectedCategory.icon,
                    watts: int.parse(_wattsController.text),
                    isOn: false,
                    category: _selectedCategory,
                  );
                  widget.onAdd(device);
                  Navigator.pop(context);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Add Device'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DeviceCategory {
  cooling(
    Icons.ac_unit,
    'Cooling',
    Colors.blue,
  ),
  lighting(
    Icons.lightbulb_outline,
    'Lighting',
    Colors.amber,
  ),
  entertainment(
    Icons.tv,
    'Entertainment',
    Colors.purple,
  ),
  kitchen(
    Icons.microwave,
    'Kitchen',
    Colors.orange,
  ),
  laundry(
    Icons.local_laundry_service,
    'Laundry',
    Colors.cyan,
  ),
  other(
    Icons.devices_other,
    'Other',
    Colors.grey,
  );

  final IconData icon;
  final String label;
  final Color color;

  const DeviceCategory(this.icon, this.label, this.color);
}

class Device {
  final String name;
  final IconData icon;
  final int watts;
  final DeviceCategory category;
  bool isOn;

  Device({
    required this.name,
    required this.icon,
    required this.isOn,
    required this.watts,
    required this.category,
  });
}

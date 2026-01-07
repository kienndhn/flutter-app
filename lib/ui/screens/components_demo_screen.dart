import 'package:flutter/material.dart';

class ComponentsDemoScreen extends StatefulWidget {
  const ComponentsDemoScreen({super.key});

  @override
  State<ComponentsDemoScreen> createState() => _ComponentsDemoScreenState();
}

class _ComponentsDemoScreenState extends State<ComponentsDemoScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Components Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Container Components (View equivalent)
            _buildSection(
              '1. Container Components (View equivalent)',
              [
                _buildComparisonCard(
                  'React Native: View',
                  'Flutter: Container',
                  [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Text(
                          'Container với padding, margin, decoration'),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ColoredBox(
                        color: Colors.green.shade100,
                        child: const Center(
                          child: Text('SizedBox - Fixed size container'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 2. Text Components
            _buildSection(
              '2. Text Components',
              [
                _buildComparisonCard(
                  'React Native: Text',
                  'Flutter: Text',
                  [
                    const Text(
                      'Text cơ bản',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Text với style',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Text với nhiều style',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                _buildComparisonCard(
                  'React Native: TextInput',
                  'Flutter: TextField',
                  [
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'TextField cơ bản',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'TextFormField với validation',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.security),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ],
            ),

            // 3. List Components (FlatList equivalent)
            _buildSection(
              '3. List Components (FlatList equivalent)',
              [
                _buildComparisonCard(
                  'React Native: FlatList',
                  'Flutter: ListView.builder',
                  [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(_items[index]),
                            subtitle: Text('Subtitle cho ${_items[index]}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Tapped: ${_items[index]}')),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 4. Button Components
            _buildSection(
              '4. Button Components',
              [
                _buildComparisonCard(
                  'React Native: TouchableOpacity',
                  'Flutter: ElevatedButton, TextButton',
                  [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('ElevatedButton pressed')),
                              );
                            },
                            child: const Text('ElevatedButton'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('TextButton pressed')),
                              );
                            },
                            child: const Text('TextButton'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('OutlinedButton pressed')),
                              );
                            },
                            child: const Text('OutlinedButton'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('IconButton pressed')),
                              );
                            },
                            icon: const Icon(Icons.favorite),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.red.shade100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // 5. Touchable Components
            _buildSection(
              '5. Touchable Components',
              [
                _buildComparisonCard(
                  'React Native: TouchableOpacity',
                  'Flutter: InkWell, GestureDetector',
                  [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('InkWell tapped')),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.touch_app, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('InkWell với ripple effect'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('GestureDetector tapped')),
                        );
                      },
                      onLongPress: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('GestureDetector long pressed')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.gesture, color: Colors.green),
                            SizedBox(width: 8),
                            Text('GestureDetector (tap + long press)'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 6. Layout Components
            _buildSection(
              '6. Layout Components',
              [
                _buildComparisonCard(
                  'React Native: Flexbox',
                  'Flutter: Row, Column, Expanded',
                  [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.red.shade100,
                            child: const Center(child: Text('Flex: 1')),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            color: Colors.blue.shade100,
                            child: const Center(child: Text('Flex: 2')),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.green.shade100,
                            child: const Center(child: Text('Flex: 1')),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.orange.shade100,
                          child: const Center(child: Text('Column item 1')),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.purple.shade100,
                          child: const Center(child: Text('Column item 2')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildComparisonCard(
      String reactNativeTitle, String flutterTitle, List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    reactNativeTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                Expanded(
                  child: Text(
                    flutterTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

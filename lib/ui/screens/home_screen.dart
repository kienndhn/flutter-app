import 'package:flutter/material.dart';
import 'package:flutter_template_app/ui/screens/list_post_screen.dart';
import 'detail_screen.dart';
import 'components_demo_screen.dart';
import 'image_demo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thông báo')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              elevation: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chào mừng bạn!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hôm nay là một ngày tuyệt vời',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Thao tác nhanh',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildQuickActionCard(
                  icon: Icons.add_circle,
                  title: 'Thêm mới',
                  color: Colors.green,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Thêm mới')),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.list,
                  title: 'Danh sách',
                  color: Colors.orange,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Danh sách')),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.settings,
                  title: 'Cài đặt',
                  color: Colors.purple,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cài đặt')),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.settings,
                  title: 'Bài viết',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => ListPostScreen()),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.widgets,
                  title: 'Components',
                  color: Colors.teal,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ComponentsDemoScreen(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.image,
                  title: 'Images',
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ImageDemoScreen(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  icon: Icons.info,
                  title: 'Chi tiết',
                  color: Colors.red,
                  onTap: () {
                    // Navigation đến màn hình mới
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DetailScreen(
                          title: 'Màn hình chi tiết',
                          description:
                              'Đây là màn hình chi tiết được tạo mới để demo navigation và lifecycle của Flutter widgets.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Items
            const Text(
              'Mục gần đây',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentItemList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentItemList(BuildContext context) {
    final recentItems = [
      {
        'title': 'Item 1',
        'subtitle': 'Mô tả item 1',
        'time': '2 giờ trước',
        'description': 'Chi tiết về item 1 - Đây là một item rất quan trọng'
      },
      {
        'title': 'Item 2',
        'subtitle': 'Mô tả item 2',
        'time': '5 giờ trước',
        'description': 'Chi tiết về item 2 - Item này có nhiều thông tin thú vị'
      },
      {
        'title': 'Item 3',
        'subtitle': 'Mô tả item 3',
        'time': '1 ngày trước',
        'description': 'Chi tiết về item 3 - Một item với nhiều tính năng'
      },
      {
        'title': 'Item 4',
        'subtitle': 'Mô tả item 4',
        'time': '2 ngày trước',
        'description': 'Chi tiết về item 4 - Item cuối cùng trong danh sách'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentItems.length,
      itemBuilder: (context, index) {
        final item = recentItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(item['title']!),
            subtitle: Text(item['subtitle']!),
            trailing: Text(
              item['time']!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              // Navigation đến DetailScreen với data
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    title: item['title']!,
                    description: item['description']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

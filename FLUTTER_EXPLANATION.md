# 🚀 Flutter - Nguyên lý hoạt động và cách thêm màn hình

## 📋 Mục lục
1. [Nguyên lý hoạt động của Flutter](#nguyên-lý-hoạt-động)
2. [Widget System](#widget-system)
3. [State Management](#state-management)
4. [Navigation](#navigation)
5. [Cách thêm màn hình mới](#thêm-màn-hình-mới)
6. [Best Practices](#best-practices)

---

## 🏗️ Nguyên lý hoạt động

### **1. Kiến trúc Flutter**

Flutter sử dụng **3-layer architecture**:

```
┌─────────────────────────────────────┐
│           Dart Framework            │
│  • Widgets (Material/Cupertino)     │
│  • Rendering                        │
│  • Animation                        │
├─────────────────────────────────────┤
│           Flutter Engine            │
│  • Skia (2D rendering)              │
│  • Dart VM                          │
│  • Platform Channels                │
├─────────────────────────────────────┤
│         Platform Layer              │
│  • iOS (Objective-C/Swift)          │
│  • Android (Java/Kotlin)            │
│  • Web (JavaScript)                 │
└─────────────────────────────────────┘
```

### **2. Rendering Pipeline**

```
1. Build Phase
   └── Widget Tree (Declarative)
       └── Element Tree (Intermediate)
           └── Render Tree (Imperative)

2. Layout Phase
   └── Constraints → Sizes → Positions

3. Paint Phase
   └── Skia → GPU → Screen
```

### **3. Hot Reload vs Hot Restart**

- **Hot Reload**: Giữ state, chỉ update UI
- **Hot Restart**: Reset toàn bộ app

---

## 🧩 Widget System

### **Types of Widgets**

#### **1. StatelessWidget**
```dart
class MyWidget extends StatelessWidget {
  final String title;
  
  const MyWidget({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
```

#### **2. StatefulWidget**
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;
  
  void _increment() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_counter'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Tăng'),
        ),
      ],
    );
  }
}
```

### **Widget Lifecycle**

```
StatelessWidget:
└── build() → dispose()

StatefulWidget:
└── createState()
    ├── initState()
    ├── didChangeDependencies()
    ├── build() ← (repeated)
    ├── didUpdateWidget()
    └── dispose()
```

---

## 🔄 State Management

### **1. setState() - Local State**
```dart
setState(() {
  _counter++;
});
```

### **2. Provider - Global State**
```dart
// Provider
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
}

// Usage
Consumer<CounterProvider>(
  builder: (context, counter, child) {
    return Text('${counter.count}');
  },
)
```

### **3. Other Options**
- **Bloc/Cubit**: Complex state management
- **Riverpod**: Modern provider alternative
- **GetX**: All-in-one solution
- **Redux**: Predictable state container

---

## 🧭 Navigation

### **1. Navigator 1.0 (Traditional)**
```dart
// Push to new screen
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => DetailScreen(title: 'Hello'),
  ),
);

// Pop back
Navigator.of(context).pop();

// Push and replace
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => HomeScreen()),
);
```

### **2. Navigator 2.0 (Declarative)**
```dart
// Using GoRouter
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) => DetailScreen(
        id: state.pathParameters['id']!,
      ),
    ),
  ],
);
```

### **3. Named Routes**
```dart
// Define routes
MaterialApp(
  routes: {
    '/': (context) => HomeScreen(),
    '/detail': (context) => DetailScreen(),
  },
);

// Navigate
Navigator.of(context).pushNamed('/detail');
```

---

## ➕ Thêm màn hình mới

### **Bước 1: Tạo file màn hình**
```dart
// lib/screens/new_screen.dart
import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  final String title;
  
  const NewScreen({super.key, required this.title});
  
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text('Màn hình mới: ${widget.title}'),
      ),
    );
  }
}
```

### **Bước 2: Import và Navigate**
```dart
// Trong màn hình hiện tại
import 'new_screen.dart';

// Navigation
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => NewScreen(title: 'Hello'),
  ),
);
```

### **Bước 3: Thêm vào routes (Optional)**
```dart
// main.dart
MaterialApp(
  routes: {
    '/new': (context) => NewScreen(title: 'Default'),
  },
);
```

---

## 🎯 Best Practices

### **1. Widget Structure**
```dart
// ✅ Good
class MyWidget extends StatelessWidget {
  final String title;
  
  const MyWidget({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}

// ❌ Bad
class MyWidget extends StatelessWidget {
  String title = 'Default'; // Mutable field
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}
```

### **2. Performance**
```dart
// ✅ Use const constructors
const Text('Hello')

// ✅ Extract widgets for reusability
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

### **3. State Management**
```dart
// ✅ Use appropriate state management
// Local state → setState()
// App state → Provider/Bloc
// Complex state → Riverpod/GetX
```

### **4. Error Handling**
```dart
// ✅ Handle errors gracefully
try {
  await apiCall();
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
  );
}
```

---

## 🔧 Debugging Tips

### **1. Print Statements**
```dart
print('Widget built: ${widget.title}');
```

### **2. Flutter Inspector**
- Use DevTools for widget inspection
- Check widget tree
- Monitor performance

### **3. Hot Reload**
- Press `r` in terminal for hot reload
- Press `R` for hot restart

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Samples](https://github.com/flutter/samples)

---

## 🎉 Kết luận

Flutter là một framework mạnh mẽ với:
- **Declarative UI**: Dễ dàng tạo giao diện
- **Hot Reload**: Phát triển nhanh
- **Cross-platform**: Một codebase cho nhiều platform
- **Rich ecosystem**: Nhiều package và tools

Việc thêm màn hình mới rất đơn giản:
1. Tạo file `.dart` mới
2. Import vào file cần sử dụng
3. Sử dụng Navigator để chuyển màn hình


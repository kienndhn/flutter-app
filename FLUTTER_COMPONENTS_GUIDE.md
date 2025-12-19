# 📱 Flutter Components vs React Native

## 🎯 Tổng quan

Bảng so sánh các component thường dùng giữa Flutter và React Native:

---

## 🏗️ Container & Layout Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `View` | `Container`, `SizedBox`, `Padding` | Container cơ bản | `Container(padding: EdgeInsets.all(16))` |
| `ScrollView` | `SingleChildScrollView`, `ListView` | Scrollable content | `SingleChildScrollView(child: Column())` |
| `SafeAreaView` | `SafeArea` | Tránh notch/status bar | `SafeArea(child: Scaffold())` |
| `KeyboardAvoidingView` | `Scaffold` + `resizeToAvoidBottomInset` | Tránh keyboard | `Scaffold(resizeToAvoidBottomInset: true)` |

### **Ví dụ Container:**
```dart
// React Native: <View style={{padding: 16, backgroundColor: 'blue'}}>
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: const Text('Hello'),
)
```

---

## 📝 Text Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `Text` | `Text` | Hiển thị text | `Text('Hello', style: TextStyle(fontSize: 16))` |
| `TextInput` | `TextField`, `TextFormField` | Input field | `TextField(decoration: InputDecoration(labelText: 'Name'))` |
| `TouchableOpacity` | `GestureDetector`, `InkWell` | Touchable area | `InkWell(onTap: () {}, child: Text('Tap me'))` |

### **Ví dụ TextField:**
```dart
// React Native: <TextInput placeholder="Enter name" />
TextField(
  decoration: const InputDecoration(
    labelText: 'Enter name',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
  ),
)
```

---

## 📋 List Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `FlatList` | `ListView.builder()` | Virtualized list | `ListView.builder(itemCount: items.length, itemBuilder: (context, index) => ListTile())` |
| `SectionList` | `ListView.builder()` với custom logic | Sectioned list | Custom implementation với headers |
| `ScrollView` | `ListView()` | Simple list | `ListView(children: [Widget1(), Widget2()])` |

### **Ví dụ ListView.builder (FlatList equivalent):**
```dart
// React Native: <FlatList data={items} renderItem={({item}) => <Text>{item}</Text>} />
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
      onTap: () => print('Tapped: ${items[index]}'),
    );
  },
)
```

---

## 🔘 Button Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `TouchableOpacity` | `ElevatedButton`, `TextButton` | Button styles | `ElevatedButton(onPressed: () {}, child: Text('Press me'))` |
| `Button` | `ElevatedButton` | Primary button | `ElevatedButton(onPressed: () {}, child: Text('Submit'))` |
| `TouchableHighlight` | `InkWell` | Highlight on press | `InkWell(onTap: () {}, child: Container())` |

### **Ví dụ Buttons:**
```dart
// React Native: <TouchableOpacity onPress={() => {}}><Text>Press me</Text></TouchableOpacity>
Row(
  children: [
    ElevatedButton(
      onPressed: () => print('Pressed'),
      child: const Text('Primary'),
    ),
    TextButton(
      onPressed: () => print('Pressed'),
      child: const Text('Secondary'),
    ),
    OutlinedButton(
      onPressed: () => print('Pressed'),
      child: const Text('Outlined'),
    ),
  ],
)
```

---

## 👆 Touchable Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `TouchableOpacity` | `InkWell` | Ripple effect | `InkWell(onTap: () {}, child: Container())` |
| `TouchableHighlight` | `GestureDetector` | Custom gestures | `GestureDetector(onTap: () {}, child: Container())` |
| `TouchableWithoutFeedback` | `GestureDetector` | No visual feedback | `GestureDetector(onTap: () {}, child: Text())` |

### **Ví dụ Touchable:**
```dart
// React Native: <TouchableOpacity onPress={() => {}} style={{opacity: 0.8}}>
InkWell(
  onTap: () => print('Tapped'),
  borderRadius: BorderRadius.circular(8),
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text('Tap me'),
  ),
)
```

---

## 📐 Layout Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| Flexbox | `Row`, `Column`, `Expanded` | Layout system | `Row(children: [Expanded(child: Widget1()), Expanded(child: Widget2())])` |
| `View` với flex | `Expanded`, `Flexible` | Flex layout | `Expanded(flex: 2, child: Widget())` |
| `ScrollView` | `SingleChildScrollView` | Scrollable | `SingleChildScrollView(child: Column())` |

### **Ví dụ Layout:**
```dart
// React Native: <View style={{flexDirection: 'row'}}><View style={{flex: 1}}><Text>Left</Text></View><View style={{flex: 2}}><Text>Right</Text></View></View>
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(
        color: Colors.red.shade100,
        child: const Center(child: Text('Left')),
      ),
    ),
    Expanded(
      flex: 2,
      child: Container(
        color: Colors.blue.shade100,
        child: const Center(child: Text('Right')),
      ),
    ),
  ],
)
```

---

## 🎨 Styling Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `StyleSheet` | `TextStyle`, `BoxDecoration` | Styling | `TextStyle(fontSize: 16, color: Colors.blue)` |
| `View` với style | `Container` với `decoration` | Container styling | `BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8))` |
| `Image` | `Image` | Image display | `Image.asset('assets/image.png')` |

### **Ví dụ Styling:**
```dart
// React Native: <View style={{backgroundColor: 'blue', borderRadius: 8, padding: 16}}>
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: const Text('Styled Container'),
)
```

---

## 🔄 State Management

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `useState` | `setState()` | Local state | `setState(() { _counter++; })` |
| `useContext` | `Provider` | Global state | `Consumer<MyProvider>(builder: (context, provider, child) => Widget())` |
| `Redux` | `Bloc`, `Riverpod` | Complex state | `BlocBuilder<MyBloc, MyState>(builder: (context, state) => Widget())` |

### **Ví dụ State Management:**
```dart
// React Native: const [count, setCount] = useState(0);
class _MyWidgetState extends State<MyWidget> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_count'),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

---

## 🧭 Navigation

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `navigation.navigate()` | `Navigator.push()` | Navigate to screen | `Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()))` |
| `navigation.goBack()` | `Navigator.pop()` | Go back | `Navigator.of(context).pop()` |
| `navigation.replace()` | `Navigator.pushReplacement()` | Replace screen | `Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewScreen()))` |

### **Ví dụ Navigation:**
```dart
// React Native: navigation.navigate('Detail', {id: 1})
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => DetailScreen(id: 1),
  ),
);
```

---

## 📱 Platform-Specific Components

| React Native | Flutter | Mô tả | Ví dụ |
|-------------|---------|-------|-------|
| `Platform.OS` | `Platform.isIOS`, `Platform.isAndroid` | Platform detection | `if (Platform.isIOS) CupertinoButton() else ElevatedButton()` |
| `TouchableNativeFeedback` | `InkWell` | Native feedback | `InkWell(onTap: () {}, child: Container())` |
| `StatusBar` | `SystemChrome` | Status bar control | `SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light)` |

### **Ví dụ Platform Detection:**
```dart
// React Native: Platform.OS === 'ios' ? <Text>iOS</Text> : <Text>Android</Text>
Widget build(BuildContext context) {
  if (Platform.isIOS) {
    return const CupertinoButton(
      onPressed: null,
      child: Text('iOS Button'),
    );
  } else {
    return const ElevatedButton(
      onPressed: null,
      child: Text('Android Button'),
    );
  }
}
```

---

## 🎯 Best Practices

### **1. Performance**
```dart
// ✅ Use const constructors
const Text('Hello')

// ✅ Use ListView.builder for large lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)

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

### **2. Layout**
```dart
// ✅ Use appropriate layout widgets
Column(
  children: [
    Expanded(child: Widget1()), // Takes remaining space
    Widget2(), // Takes only needed space
  ],
)

// ✅ Use SizedBox for spacing
const SizedBox(height: 16)
const SizedBox(width: 8)
```

### **3. Styling**
```dart
// ✅ Use Theme for consistent styling
Theme.of(context).textTheme.headlineMedium

// ✅ Use BoxDecoration for complex styling
BoxDecoration(
  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
  borderRadius: BorderRadius.circular(8),
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
)
```

---

## 🔧 Common Patterns

### **1. Conditional Rendering**
```dart
// React Native: {isVisible && <Text>Visible</Text>}
if (isVisible) const Text('Visible')

// React Native: {isVisible ? <Text>Yes</Text> : <Text>No</Text>}
isVisible ? const Text('Yes') : const Text('No')
```

### **2. List Rendering**
```dart
// React Native: {items.map(item => <Text key={item.id}>{item.name}</Text>)}
...items.map((item) => Text(item.name)).toList()
```

### **3. Event Handling**
```dart
// React Native: onPress={() => handlePress()}
onPressed: () => handlePress()

// React Native: onPress={handlePress}
onPressed: handlePress
```

---

## 📚 Resources

- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Flutter Layout Tutorial](https://docs.flutter.dev/development/ui/layout)
- [Flutter Material Design](https://material.io/design)
- [Flutter Cupertino Design](https://developer.apple.com/design/human-interface-guidelines/)

---

## 🎉 Kết luận

Flutter cung cấp một hệ thống component phong phú và linh hoạt:

- **Declarative UI**: Dễ dàng tạo giao diện phức tạp
- **Rich Widget Library**: Nhiều component có sẵn
- **Customizable**: Dễ dàng tùy chỉnh và mở rộng
- **Performance**: Tối ưu hóa rendering
- **Cross-platform**: Một codebase cho nhiều platform

Việc chuyển đổi từ React Native sang Flutter sẽ dễ dàng hơn khi hiểu rõ các component tương đương!


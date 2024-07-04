// คลาส MenuItem สำหรับรายการอาหาร
class MenuItem {
  String name;
  double price;
  String category;

  MenuItem(this.name, this.price, this.category);

  @override
  String toString() {
    return '$name ($category) - \$${price.toStringAsFixed(2)}';
  }
}

// คลาส Order สำหรับการจัดการคำสั่งอาหาร
class Order {
  String orderId;
  int tableNumber;
  List<MenuItem> items = [];
  bool isCompleted = false;

  Order(this.orderId, this.tableNumber);

  void addItem(MenuItem item) {
    items.add(item);
  }

  void removeItem(MenuItem item) {
    items.remove(item);
  }

  void completeOrder() {
    isCompleted = true;
  }

  @override
  String toString() {
    return 'Order $orderId for table $tableNumber - ${isCompleted ? 'Completed' : 'In Progress'}\nItems:\n${items.join('\n')}';
  }
}

// คลาส Restaurant สำหรับการจัดการร้านอาหาร
class Restaurant {
  List<MenuItem> menu = [];
  List<Order> orders = [];
  Map<int, bool> tables = {};

  Restaurant(int numberOfTables) {
    for (int i = 1; i <= numberOfTables; i++) {
      tables[i] = false; // All tables are initially unoccupied
    }
  }

  void addMenuItem(MenuItem item) {
    menu.add(item);
  }

  void removeMenuItem(MenuItem item) {
    menu.remove(item);
  }

  void placeOrder(Order order) {
    if (!tables[order.tableNumber]!) {
      orders.add(order);
      tables[order.tableNumber] = true; // Mark the table as occupied
    } else {
      print('Table ${order.tableNumber} is already occupied.');
    }
  }

  void completeOrder(String orderId) {
    Order? order = getOrder(orderId);
    if (order != null) {
      order.completeOrder();
      tables[order.tableNumber] = false; // Mark the table as unoccupied
    } else {
      print('Order $orderId not found.');
    }
  }

  MenuItem? getMenuItem(String name) {
    try {
      return menu.firstWhere((item) => item.name == name);
    } catch (e) {
      return null; // Return null if not found
    }
  }

  Order? getOrder(String orderId) {
    try {
      return orders.firstWhere((order) => order.orderId == orderId);
    } catch (e) {
      return null; // Return null if not found
    }
  }

  @override
  String toString() {
    return 'Restaurant Menu:\n${menu.join('\n')}\n\nOrders:\n${orders.join('\n')}\n\nTables:\n${tables.entries.map((e) => 'Table ${e.key}: ${e.value ? 'Occupied' : 'Available'}').join('\n')}';
  }
}

// ฟังก์ชันหลักสำหรับทดสอบระบบ
void main() {
  // สร้างออบเจ็กต์ Restaurant
  Restaurant restaurant = Restaurant(5);

  // เพิ่มรายการอาหารในเมนู
  MenuItem item1 = MenuItem('Spaghetti', 12.5, 'อาหารคาว');
  MenuItem item2 = MenuItem('Cheesecake', 6.5, 'อาหารหวาน');
  MenuItem item3 = MenuItem('Coca-Cola', 2.0, 'เครื่องดื่ม');
  restaurant.addMenuItem(item1);
  restaurant.addMenuItem(item2);
  restaurant.addMenuItem(item3);

  // สร้างคำสั่งอาหาร
  Order order1 = Order('001', 1);
  order1.addItem(item1);
  order1.addItem(item3);

  Order order2 = Order('002', 2);
  order2.addItem(item2);

  // วางคำสั่งอาหาร
  restaurant.placeOrder(order1);
  restaurant.placeOrder(order2);

  // พิมพ์สถานะของร้านอาหาร
  print(restaurant);

  // ทำให้คำสั่งเสร็จสิ้น
  restaurant.completeOrder('001');

  // พิมพ์สถานะของร้านอาหารหลังจากทำคำสั่งเสร็จ
  print('\nAfter completing order 001:\n');
  print(restaurant);
}

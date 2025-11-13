actor OrderProcessor {
    private var orders: [String] = []

    // 주문 추가 메서드
    func addOrder(_ order: String) {
        orders.append(order)
        print("추가된 주문: \(order)")
    }

    // 주문 처리 메서드
    func processOrder() {
        if orders.isEmpty {
            print("처리할 주문 없음")
        } else {
            let order = orders.removeFirst()
            print("처리된 주문: \(order)")
        }
    }

    // 현재 남아있는 주문 출력 메서드
    func printAllOrders() {
        if orders.isEmpty {
            print("남아 있는 주문 없음")
        } else {
            print("남아 있는 주문: \(orders.joined(separator: ", "))")
        }
    }
}

let orderProcessor = OrderProcessor()

Task {
    await orderProcessor.addOrder("Pizza")
    await orderProcessor.addOrder("Burger")
    await orderProcessor.addOrder("Pasta")
    
    await orderProcessor.processOrder()
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrders()
    
    await orderProcessor.processOrder()
    
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrders()
}

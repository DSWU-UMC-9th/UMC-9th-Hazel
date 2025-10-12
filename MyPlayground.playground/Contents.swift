// 1. 구조체 Car
// 2. 속성
// - make : 제조사 이름
// - model : 모델명
// - year : 차량 연식
// - mileage : 현재 주행거리
// isRunning : 차량 상태 -> 작동 여부
// 3. 초기화 -> init(make:model:year:mileage:isRunning)

struct Car {
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var isRunning: Bool
    
    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.isRunning = isRunning
    }
    
    // 차 시동 걸기
    mutating func start() {
        if (!isRunning) {
            isRunning = true
            print("차 시동 걸림.")
        } else {
            print("차 이미 시동 중.")
        }
    }
    
    // 차 시동 중지
    mutating func stop() {
        if (isRunning) {
            isRunning = false
            print("차 시동 꺼짐.")
        } else {
            print("차 이미 꺼짐.")
        }
    }
    
    // 차 주행거리 출력
    mutating func drive(distance: Int) {
        if (!isRunning) {
            print("이동 불가능. 차 시동 꺼짐.")
        } else {
            mileage += Double(distance)
            print("이동거리 \(distance) km. 현재 mileage: \(Int(mileage)) km")
        }
    }
}

var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)

myCar.start() // 출력: "차 시동 걸림."
myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
myCar.stop() // 출력: "차 시동 꺼짐."
myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
myCar.start() // 출력: "차 시동 켜짐"
myCar.start() // 출력: "차 이미 시동 중."

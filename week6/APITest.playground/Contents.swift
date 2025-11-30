import SwiftUI

// MARK: - POST Method
let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "POST"

let parameters: [String: Any] = [
      "name": "리버",
      "age": 25,
      "address": "서울시 성북구",
      "height": 174
]

request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    if let error = error {
        print("에러: \(error)")
        return
    }
    
    if let httpResponse = response as? HTTPURLResponse {
        print("상태 코드: \(httpResponse.statusCode)")
    }
    
    if let data = data {
        let responseString = String(data: data, encoding: .utf8)
        print("응답: \(responseString!)")
    }
}

task.resume()

// MARK: - GET Method
//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "리버")
//]
//
//let url = urlComponents.url!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

// MARK: - PATCH Method
//import SwiftUI
//
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name": "River",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

// MARK: - PUT Method
//import SwiftUI
//
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//// 요청 본문에 전송할 데이터
//let parameters: [String: Any] = [
//    "name": "River",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

// MARK: - DELETE Method
//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "River")
//]
//
//let url = urlComponents.url!
//var request = URLRequest(url: url)
//request.httpMethod = "DELETE"
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("Status Code: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("Response Data: \(responseString!)")
//    }
//}
//task.resume()

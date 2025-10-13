//
//  CalendarViewModel.swift
//  megabox
//
//  Created by 황민지 on 10/13/25.
//

import Combine
import SwiftUI

@Observable
class CalendarViewModel {
    var currentMonth: Date // 현재 보고 있는 달의 기준 날짜
    var selectedDate: Date // 사용자가 현재 선택한 날짜
    var calendar: Calendar // 날짜 계싼을 위한 Calendar 객체
    
//    var currentMonthYear: Int { // 현재 보고 있는 연도를 계산해서 연도로 반환
//        Calendar.current.component(.year, from: currentMonth)
//    }
    
    init(currentMonth: Date = Date(), selectedDate: Date = Date(), calendar: Calendar = Calendar.current) {
        self.currentMonth = currentMonth
        self.selectedDate = Date()
        self.calendar = calendar
    }
    
    /// 오늘(또는 선택된 날짜)부터 토요일까지 보여주는 7일짜리 배열
    func daysForCurrentWeekFromToday() -> [CalendarDay] {
        let calendar = Calendar.current
        let today = Date()
        
        var days: [CalendarDay] = []
        
        // 오늘부터 7일간
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                let day = calendar.component(.day, from: date)
                let isCurrentMonth = calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
                
                days.append(
                    CalendarDay(day: day, date: date, isCurrentMonth: isCurrentMonth)
                )
            }
        }
        return days
    }

    // 해당 날짜의 요일을 반환
    func weekdayString(for date: Date) -> String {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.locale = Locale(identifier: "ko_KR")
        
        if calendar.isDateInToday(date) {
            formatter.dateFormat = "오늘"
        } else if calendar.isDateInTomorrow(date) {
            formatter.dateFormat = "내일"
        } else {
            formatter.dateFormat = "E" // 월, 화, 수, 목, 금, 토, 일
        }
        
        return formatter.string(from: date)
    }
    
    // 해당 날짜가 평일인지에 대한 여부 반환
    func isSunday(_ date: Date) -> Bool {
        return calendar.component(.weekday, from: date) == 1
    }
    
    // 해당 날짜가 토요일인지에 대한 여부 반환
    func isSaturday(_ date: Date) -> Bool {
        return calendar.component(.weekday, from: date) == 7
    }
    
    /// 사용자가 날짜를 선택했을 때, 기존 선택된 날짜와 비교하여 필요할 경우에만 선택 날짜를 갱신할 수 있도록 합니다. 달력 앱에서 불필요한 상태 업데이트를 방지하고, 성능을 높이기 위해 자주 사용하는 방식이에요!
    /// - Parameter date: 선택한 날짜 업데이트
    public func changeSelectedDate(_ date: Date) {
        if calendar.isDate(selectedDate, inSameDayAs: date) {
            return
        } else {
            selectedDate = date
        }
    }
}

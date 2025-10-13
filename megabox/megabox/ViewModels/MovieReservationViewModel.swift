//
//  MovieReservationViewModel.swift
//  megabox
//
//  Created by 황민지 on 10/12/25.
//

import Combine
import SwiftUI

final class MovieReservationViewModel: ObservableObject {
    
    @Published private(set) var movies: [Movie] = []           // 전체 영화 목록
    @Published private(set) var theaters: [Theater] = []       // 전체 극장 목록
    @Published private(set) var screenings: [Screening] = []   // 전체 상영 정보
    
    @Published var selectedMovie: Movie? = nil                 // 선택된 영화
    @Published var selectedTheaters: Set<String> = []            // 선택된 극장들
    @Published var selectedDate: Date = Date()                 // 선택된 날짜
    
    @Published var filteredScreenings: [Screening] = []        // 조건에 맞는 상영정보 결과
    
    // UI 상태
    @Published var isTheaterEnabled: Bool = false
    @Published var isDayEnabled: Bool = false

    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        setupDummyData()
        setupBindings()
    }
    
    // MARK: - Dummy Data
    private func setupDummyData() {
        let today = Date()
        
        // 영화 더미 데이터
        let movie1 = Movie(title: "어쩔수가 없다", poster: Image("poster1"))
        let movie2 = Movie(title: "극장판 귀멸의 칼날 : 무한성편", poster: Image("poster2"))
        let movie3 = Movie(title: "F1 더 무비", poster: Image("poster3"))
        let movie4 = Movie(title: "얼굴", poster: Image("poster4"))
        let movie5 = Movie(title: "모노노케 히메", poster: Image("poster5"))
        let movie6 = Movie(title: "야당", poster: Image("poster6"))
        let movie7 = Movie(title: "보스", poster: Image("poster7"))
        let movie8 = Movie(title: "The Roses", poster: Image("poster8"))

        
        movies = [
            movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8
        ]
        
        // 상영관
        let hall1 = Hall(name: "크리클라이너 1관", totalSeatsCount: 116, screenType: .twoD)
        let hall2 = Hall(name: "BST관 (7층 1관 [Laser])", totalSeatsCount: 120, screenType: .twoD)
        let hall3 = Hall(name: "BTS관 (9층 2관 [Laser])", totalSeatsCount: 150, screenType: .fourD)
        
        // 🏢 극장 (지점)
        let gangnam = Theater(name: "강남", halls: [hall1, hall2])
        let hongdae = Theater(name: "홍대", halls: [hall1, hall2])
        let sinchon = Theater(name: "신촌", halls: [hall3])
        
        theaters = [gangnam, hongdae, sinchon]
        
        // 🎞 상영정보 (Screening)
        screenings = [
            // 강남
            Screening(movie: movie1, theater: gangnam, hall: hall1,
                      date: today, startTime: "10:00", endTime: "12:30", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: gangnam, hall: hall1,
                      date: today, startTime: "12:40", endTime: "15:10", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: gangnam, hall: hall1,
                      date: today, startTime: "15:20", endTime: "17:50", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: gangnam, hall: hall2,
                      date: today, startTime: "18:00", endTime: "20:30", reservedSeatsCount: 78),
            Screening(movie: movie2, theater: gangnam, hall: hall1,
                      date: today, startTime: "12:00", endTime: "15:30", reservedSeatsCount: 90),
            Screening(movie: movie2, theater: hongdae, hall: hall2,
                      date: today, startTime: "16:00", endTime: "18:10", reservedSeatsCount: 60),
            Screening(movie: movie2, theater: gangnam, hall: hall1,
                      date: today, startTime: "19:00", endTime: "21:30", reservedSeatsCount: 90),
            
            // 홍대
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "11:30", endTime: "13:40", reservedSeatsCount: 50),
            Screening(movie: movie2, theater: hongdae, hall: hall1,
                      date: today, startTime: "19:00", endTime: "21:30", reservedSeatsCount: 90),
            Screening(movie: movie2, theater: hongdae, hall: hall2,
                      date: today, startTime: "16:00", endTime: "18:10", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "10:00", endTime: "12:30", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "12:40", endTime: "15:10", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "15:20", endTime: "17:50", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "15:20", endTime: "17:50", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall1,
                      date: today, startTime: "15:20", endTime: "17:50", reservedSeatsCount: 60),
            Screening(movie: movie1, theater: hongdae, hall: hall2,
                      date: today, startTime: "18:00", endTime: "20:30", reservedSeatsCount: 78),
            Screening(movie: movie2, theater: hongdae, hall: hall3,
                      date: today, startTime: "12:00", endTime: "15:30", reservedSeatsCount: 90),
            Screening(movie: movie2, theater: hongdae, hall: hall2,
                      date: today, startTime: "16:00", endTime: "18:10", reservedSeatsCount: 60),
            Screening(movie: movie2, theater: hongdae, hall: hall3,
                      date: today, startTime: "19:00", endTime: "21:30", reservedSeatsCount: 90),
            
            // 신촌
            Screening(movie: movie4, theater: sinchon, hall: hall3,
                      date: today, startTime: "11:30", endTime: "13:40", reservedSeatsCount: 50),
            Screening(movie: movie7, theater: sinchon, hall: hall3,
                      date: today, startTime: "19:00", endTime: "21:30", reservedSeatsCount: 90),
            Screening(movie: movie3, theater: sinchon, hall: hall3,
                      date: today, startTime: "14:00", endTime: "16:00", reservedSeatsCount: 72)
        ]
    }
    
    // MARK: - Combine Bindings
    private func setupBindings() {
        // 영화 선택 → 극장 버튼 활성화
        $selectedMovie
            .map { $0 != nil }
            .assign(to: \.isTheaterEnabled, on: self)
            .store(in: &bag)
        
        // 영화 변경 -> 자동으로 상영 정보 다시 필터링
        $selectedMovie
            .sink { [weak self] movie in
                guard let self = self else { return }

                // 🔹 영화 해제 시만 리셋
                if movie == nil {
                    self.filteredScreenings.removeAll()
                    self.selectedTheaters.removeAll()
                    self.isTheaterEnabled = false
                    self.isDayEnabled = false
                    return
                }

                // 🔹 영화 새로 선택되면 기존 극장은 그대로 두고 상영정보만 새로 필터
                DispatchQueue.main.async {
                    self.isTheaterEnabled = true
                    self.filterScreenings()
                }
            }
            .store(in: &bag)

        
        // 극장 선택 → 날짜 버튼 활성화
        $selectedTheaters
            .map { !$0.isEmpty }
            .assign(to: \.isDayEnabled, on: self)
            .store(in: &bag)
        
        // 극장 변경 시 필터링
        $selectedTheaters
            .sink { [weak self] _ in
                self?.filterScreenings()
            }
            .store(in: &bag)
        
        // 날짜 변경 시 필터링
        $selectedDate
            .sink { [weak self] _ in
                self?.filterScreenings()
            }
            .store(in: &bag)
    }
    
    // MARK: - Filter Logic
    func filterScreenings() {
        guard let movie = selectedMovie, !selectedTheaters.isEmpty else {
            filteredScreenings = []
            return
        }

        let calendar = Calendar.current
        filteredScreenings = screenings.filter { screening in
            screening.movie.id == movie.id &&
            selectedTheaters.contains(screening.theater.name) &&
            calendar.isDate(screening.date, inSameDayAs: selectedDate)
        }
    }

}

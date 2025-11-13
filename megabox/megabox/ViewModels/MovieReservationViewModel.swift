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
    
    @Published var query: String = ""
    @Published var results: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // UI 상태
    @Published var isTheaterEnabled: Bool = false
    @Published var isDayEnabled: Bool = false

    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        Task {
            await fetchShowtimes()
        }
        
        setupBindings()
        
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag)
    }
    
    // MARK: - fetchShowtimes
    func fetchShowtimes() async {
        isLoading = true
        
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
            print("JSON 파일을 찾을 수 없습니다.")
            errorMessage = "MovieSchedule.json 파일이 없습니다."
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let response = try JSONDecoder().decode(APIResponseDTO.self, from: data)
            
            let domainMovies = response.data.movies.map(MovieMapper.toDomain)
            let domainScreenings = response.data.movies.flatMap(MovieMapper.toScreenings)
            
            let theaterNames = Set(domainScreenings.map { $0.theater.name })
            let domainTheaters = theaterNames.map { name -> Theater in
                let halls = domainScreenings
                    .filter { $0.theater.name == name }
                    .map { $0.hall }
                return Theater(name: name, halls: halls)
            }
            
            self.movies = domainMovies
            self.screenings = domainScreenings
            self.theaters = domainTheaters
            self.isLoading = false
            
            print("movies 개수:", self.movies.count)
            
        } catch {
            self.errorMessage = "디코딩 실패: \(error.localizedDescription)"
            self.isLoading = false
            print("디코딩 실패: ", error)
        }
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
    
    // MARK: - Screenings 필터
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
        
        print("필터 결과:", filteredScreenings.map { "\($0.theater.name)-\($0.hall.name)" })
    }
    
    // MARK: - search 함수
    private func search(query: String) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.movies.filter {
                    $0.title.lowercased().contains(query.lowercased())
                }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }
}

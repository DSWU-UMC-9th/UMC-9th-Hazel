//
//  MovieReservationView.swift
//  megabox
//
//  Created by 황민지 on 10/12/25.
//

import SwiftUI
import Combine

struct MovieReservationView : View {
    
    @StateObject private var viewModel = MovieReservationViewModel()
    @State private var calendarViewModel = CalendarViewModel()
    @State private var isMovieSearchSheetPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            Header   // 상단 네비게이션바
            MovieSection // 영화 섹션
            TheaterButtonSection // 버튼 섹션(극장)
            DaySection // 날짜 선택 섹션
            ScrollView {
                ScreeningSection // 상영 정보 섹션
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $isMovieSearchSheetPresented) {
            MovieSearchSheet(viewModel: viewModel) { selected in
                viewModel.selectedMovie = selected
                isMovieSearchSheetPresented = false
            }
                .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - 상단 네비게이션 바
    private var Header: some View {
        ZStack(alignment: .bottom) {
            Color.purple03
                .ignoresSafeArea(edges: .top)
                        
            Text("영화별 예매")
                .font(.bold22)
                .foregroundStyle(.white)
                .padding(.bottom, 10)
        }
        .frame(height: 125)
    }
    
    // MARK: - 영화 섹션
    private var MovieSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                if let selectedMoviePoster = viewModel.selectedMovie {
                    Image(.ageRating)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Spacer().frame(width: 37)
                    
                    Text(selectedMoviePoster.title)
                        .font(.bold18)
                        .foregroundStyle(.black)
                    
                    Spacer()
                } else {
                    Spacer()
                }
                
                Button(action: {
                    isMovieSearchSheetPresented.toggle()
                    print("전체영화 버튼 클릭")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray02, lineWidth: 1)
                            .frame(width: 69, height: 30, alignment: .trailing)
                            .background(.white)
                        
                        Text("전체영화")
                            .font(.semiBold14)
                            .foregroundColor(.black)
                            .frame(alignment: .center)
                    }
                    
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(viewModel.movies) {movie in
                        
                        Button {
                            viewModel.selectedMovie = (viewModel.selectedMovie?.id == movie.id ? nil : movie)

                        } label: {
                            movie.poster
                                .resizable()
                                .frame(width: 62, height: 89)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(viewModel.selectedMovie?.id == movie.id ? .purple03 : .clear, lineWidth: 3)
                                )
                        }
                    }
                }
                .frame(height: 89)
                .padding(.horizontal, 16)
            }
        }
        .padding(.bottom, 32)
    }
    
    // MARK: - 지점 클릭 버튼 활성화
    private var TheaterButtonSection: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.theaters) {theater in
                Button {
                    // 영화가 선택된 상태일 때만 지점 클릭 버튼 활성화
                    guard viewModel.isTheaterEnabled else { return }
                    
                    if viewModel.selectedTheaters.contains(theater.name) {
                        viewModel.selectedTheaters.remove(theater.name)
                    } else {
                        viewModel.selectedTheaters.insert(theater.name)
                    }

                    // 상영정보 갱신 (선택 지점 변경 시 반영)
                    viewModel.filterScreenings()
                    
                    print("\(theater.name) 클릭됨: \(viewModel.selectedTheaters)")
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(viewModel.selectedTheaters.contains(theater.name) ? .purple03 : .gray01)
                            .frame(width: 55, height: 35)
                        
                        Text("\(theater.name)")
                            .font(.semiBold14)
                            .foregroundColor(viewModel.selectedTheaters.contains(theater.name) ? .white :.gray05)
                            .frame(alignment: .center)
                    }
                }
                .disabled(!viewModel.isTheaterEnabled) // 영화 미선택 시 비활성화
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }
    
    // MARK: - 날짜 선택
    private var DaySection: some View {
        
        let days = calendarViewModel.daysForCurrentWeekFromToday()
        
        return HStack(spacing: 5) {
            ForEach(days, id: \.date) { day in
                
                let isSelectedDay = calendarViewModel.calendar.isDate(day.date, inSameDayAs: calendarViewModel.selectedDate)
                
                Button {
                    // 상영관 선택된 상태일 때만 날짜 클릭 버튼 활성화
                    guard viewModel.isDayEnabled else { return }
                    
                    // 날짜 선택
                    calendarViewModel.changeSelectedDate(day.date)
                    
                    viewModel.selectedDate = day.date
                    viewModel.filterScreenings() // 날짜 변경 시 필터링
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSelectedDay ? .purple03 : .clear)
                            .frame(width: .infinity, height: 60)
                        
                        VStack(alignment: .center, spacing: 4) {
                            
                            Text(formatDate(day.date))
                                .foregroundStyle(
                                    isSelectedDay
                                    ? .white
                                    : calendarViewModel.isSaturday(day.date)
                                        ? .tag
                                        : calendarViewModel.isSunday(day.date)
                                            ? .holiday
                                            : .black
                                )
                                .font(.bold18)
                            Text(calendarViewModel.weekdayString(for: day.date))
                                .foregroundStyle(isSelectedDay ? .white : .gray03)
                                .font(.semiBold14)
                                
                        }
                    }
                    .disabled(!viewModel.isDayEnabled) // 극장 미선택 시 비활성화
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 49)
    }
    
    // MARK: - 상영 정보 섹션
    private var ScreeningSection: some View {
        VStack(alignment: .leading, spacing: 29) {

            // MARK: - 선택된 극장 for문
            ForEach(viewModel.theaters.filter { viewModel.selectedTheaters.contains($0.name) }) { theater in
                let theaterScreenings = viewModel.filteredScreenings.filter {
                    $0.theater.id == theater.id
                }

                VStack(alignment: .leading, spacing: 21) {
                    Text(theater.name)
                        .font(.bold18)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // MARK: - 상영관 for문
                    if theaterScreenings.isEmpty {
                        Text("선택한 극장에 상영시간표가 없습니다")
                            .font(.semiBold18)
                            .foregroundStyle(.gray03)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(theater.halls, id: \.id) { hall in
                            let hallScreenings = theaterScreenings.filter {
                                $0.hall.id == hall.id
                            }

                            if !hallScreenings.isEmpty {
                                VStack(alignment: .leading, spacing: 21) {
                                    HStack {
                                        Text(hall.name)
                                            .font(.bold18)
                                        Spacer()
                                        Text(hall.screenType.rawValue)
                                            .font(.bold18)
                                    }

                                    // MARK: - 상영 정보 카드
                                    let columns: [GridItem] = Array(
                                        repeating: GridItem(.flexible(), alignment: .top),
                                        count: 4
                                    )

                                    LazyVGrid(columns: columns, alignment: .leading, spacing: 19) {
                                        ForEach(hallScreenings, id: \.id) { screening in
                                            ScreeningCard(screening: screening)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }

    
   // MARK: - 날짜 포맷팅 (오늘=MM.dd / 달 바뀌면 MM.dd / 나머지는 d)
   private func formatDate(_ date: Date) -> String {
       let calendar = Calendar.current
       let formatter = DateFormatter()
       formatter.dateFormat = "d"
       
       // 오늘이면 MM.dd
       if calendar.isDateInToday(date) {
           formatter.dateFormat = "MM.dd"
       }
       return formatter.string(from: date)
   }
    
    //MARK: - 상영 카드
    struct ScreeningCard: View {
        let screening: Screening
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(screening.startTime)")
                    .font(.bold18)
                    .foregroundStyle(.black)
                Text("~ \(screening.endTime)")
                    .font(.regular12)
                    .foregroundStyle(.gray03)
                
                HStack(spacing: 4) {
                    Text("\(screening.hall.totalSeatsCount)")
                        .font(.semiBold14)
                        .foregroundStyle(.purple03)
                    Text("/ \(screening.reservedSeatsCount)")
                        .font(.semiBold14)
                        .foregroundStyle(.gray02)
                }
            }
            .frame(width: 75, height: 86)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 1)
            )
        }
    }
}


#Preview {
    MovieReservationView()
}

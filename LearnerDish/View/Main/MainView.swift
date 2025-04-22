//
//  MainView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//


//
//  MainView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//
import SwiftUI
import FirebaseFirestore

struct MainView: View {
    
    @EnvironmentObject var userModel: UserModel
    @StateObject private var firestoreManager = FirestoreManager()
    
    @State private var showFoodList = false
    @State private var goToRunnerDish = false
    @State private var goToMyDishView = false
    @State private var selectedDish: DishModel? = nil

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    CheckBackground(
                        lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                        backgroundColor: Color(red: 1, green: 0.95, blue: 0.83),
                        cornerRadius: 30,
                        opacity: 1.0
                    )

                    VStack(spacing: -60) {
                        //Color(red: 1, green: 0.94, blue: 0.63)
                       // Color(red: 1, green: 0.84, blue: 0.38)
                        //Color(red: 1, green: 0.88, blue: 0.53)
                        Color(red: 1, green: 0.92, blue: 0.55)
                        //Color(red: 1, green: 0.87, blue: 0.43)
                        
                            .frame(height: 120)
                            .ignoresSafeArea(edges: .top)

                        ScrollView {
                            ZStack(alignment: .top) {
                                CheckBackground(
                                    lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                                    backgroundColor: Color(red: 1, green: 0.95, blue: 0.83),
                                    cornerRadius: 0,
                                    opacity: 1.0
                                )
                                //.frame(height: 100)
                                
                                Group{
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 78) //크기
                                        .offset(x:110, y:100)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 94) //크기
                                        .offset(x:-120, y:340)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 200))
                                        .frame(width: 94) //크기
                                        .offset(x:120, y:70)
                                        .zIndex(10)
                                        .padding(.top, 460)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 20))
                                        .frame(width: 78) //크기
                                        .offset(x:130, y:100)
                                        .zIndex(10)
                                        .padding(.top,490)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: -30))
                                        .frame(width: 78) //크기
                                        .offset(x:-130, y:100)
                                        .zIndex(10)
                                        .padding(.top,790)
                                } //coffee&fork
                                
                                Group{
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 78) //크기
                                        .offset(x:110, y:100)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 94) //크기
                                        .offset(x:-120, y:390)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 200))
                                        .frame(width: 94) //크기
                                        .offset(x:120, y:70)
                                        .zIndex(10)
                                        .padding(.top, 460)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 20))
                                        .frame(width: 78) //크기
                                        .offset(x:130, y:100)
                                        .zIndex(10)
                                        .padding(.top,490)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: -30))
                                        .frame(width: 78) //크기
                                        .offset(x:-130, y:100)
                                        .zIndex(10)
                                        .padding(.top,750)
                                }
                                .offset(y:1000) //coffee&fork
                                
                                Group{
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 78) //크기
                                        .offset(x:110, y:100)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 94) //크기
                                        .offset(x:-120, y:350)
                                        .zIndex(10)
                                    
                                    Image("fork")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 200))
                                        .frame(width: 94) //크기
                                        .offset(x:120, y:70)
                                        .zIndex(10)
                                        .padding(.top, 460)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: 20))
                                        .frame(width: 78) //크기
                                        .offset(x:130, y:100)
                                        .zIndex(10)
                                        .padding(.top,490)
                                    
                                    Image("coffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .rotationEffect(Angle(degrees: -30))
                                        .frame(width: 78) //크기
                                        .offset(x:-130, y:100)
                                        .zIndex(10)
                                        .padding(.top,750)
                                }
                                .offset(y:1920)
                                    
                                VStack{ //tablemat
                                    Image("TableMat01") //오
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 350, height:370) //크기
                                        .offset(x:110, y:50)
                                    
                                    Image("TableMat02")
                                        .resizable()
                                        //.aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(width: 300,height:360) //크기
                                        .offset(x:-160, y:50)
                                        .padding(.top, 10)
                                    
                                    Image("TableMat03")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(height:700) //크기
                                        .offset(x:190, y:-120)
                                        .padding(.top, 0)
                                        .rotationEffect(Angle(degrees: -20.61))
                                    
                                    Image("TableMat04")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) //원본 비율 유지
                                        .frame(height:500) //크기
                                        .rotationEffect(Angle(degrees: 90))
                                        .offset(x:-100, y:-320)
                                        .padding(.top, 0)
                                    
                                    
                                    Group {
                                        Image("TableMat01") //오
                                            .resizable()
                                            .aspectRatio(contentMode: .fit) //원본 비율 유지
                                            .frame(width: 350, height:350) //크기
                                            .offset(x:110, y:20)
                                            //.padding(.top, 30)
                                        
                                        Image("TableMat02")
                                            .resizable()
                                        //.aspectRatio(contentMode: .fit) //원본 비율 유지
                                            .frame(width: 300,height:350) //크기
                                            .offset(x:-160, y:14)
                                            .padding(.top, 10)
                                        
                                        Image("TableMat03")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit) //원본 비율 유지
                                            .frame(height:700) //크기
                                            .offset(x:190, y:-120)
                                            .padding(.top, 0)
                                            .rotationEffect(Angle(degrees: -20.61))
                                        
                                        Image("TableMat04")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit) //원본 비율 유지
                                            .rotationEffect(Angle(degrees: 0))
                                            .frame(height:300) //크기
                                            .offset(x:-100, y:-300)
                                            .padding(.top, 30)
                                    }
                                    .offset(y:-350)
                                        
                                } //TableMat
                                .offset(y:850)
                                .frame(height:2000)
                                .background(Color.clear)
                                //.opacity(0.9)
                                

                                FinalDishList(
                                    dishes: firestoreManager.dishes,
                                    onSelect: { dish in
                                        selectedDish = dish
                                        goToRunnerDish = true
                                        print("✅ 선택된 디쉬: \(dish.nickname)")
                                        print("📄 접시 문서 ID: \(dish.id ?? "없음")")
                                    }
                                )
                                .padding(.top, 40)
                                .offset(y:-40) //첫 접시 시작 높이
                                .background(Color.clear)
                                
                            
                            }
                            //.frame(maxWidth: .infinity, alignment: .top)
    
                        }
                        
                        .background(Color.clear)
                        .refreshable {
                            firestoreManager.fetchDishes {
                                firestoreManager.dishes.shuffle()
                        
                        
                            }
                        }
                    }

                    VStack(spacing: 8) {
                        ZStack {
                            Text("만나고 싶은 디쉬를 골라보세요")
                                .font(Font.custom("210 Everybody", size: 25).weight(.bold))
                                //.shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 0)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                                .padding(.vertical, 3)
                                .padding(.horizontal, 18)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)

                            HStack {
                                Spacer()
                                Button(action: {
                                    showFoodList = true
                                }) {
                                    Image("FoodListButton")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .padding(.trailing, 34)
                        }
                        .padding(.top, 10)

                        HStack {
                            Spacer()
                            Button(action: {
                                goToMyDishView = true
                                print("MyButton tapped")
                            }) {
                                Image("MyButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55)
                                    .offset(y:10)
                                    //.shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
                            }
                            .padding(.trailing, 20) //my 버튼 오른쪽 여백
                        }

                        Spacer()
                    }
                    .zIndex(1)

                    if showFoodList {
                        FoodListView(isPresented: $showFoodList)
                            .background(Color.black.opacity(0.4).ignoresSafeArea())
                            .transition(.opacity)
                            .zIndex(2)
                    }

                    // ✅ Navigation: 접시 클릭 → RunnerDishView
                    NavigationLink(
                        destination: Group {
                            if let dish = selectedDish {
                                RunnerDishView(dish: dish)
                            }
                        },
                        isActive: $goToRunnerDish
                    ) {
                        EmptyView()
                    }

                    // ✅ Navigation: MyButton → MyDishView
                    NavigationLink(
                        destination: MyDishView()
                            .navigationBarBackButtonHidden(true),
                        isActive: $goToMyDishView
                    ) {
                        EmptyView()
                    }
                }
            }
            .onAppear {
                firestoreManager.fetchDishes()

                // ✅ 내 정보 복원 시도
                if let nickname = UserDefaults.standard.string(forKey: "nickname"),
                   let dishID = UserDefaults.standard.string(forKey: "myDishID") {

                    userModel.nickname = nickname
                    userModel.myDishID = dishID

                    Firestore.firestore().collection("dishes").document(dishID).getDocument { snapshot, error in
                        if let data = snapshot?.data() {
                            let dish = DishModel(
                                id: dishID,
                                nickname: data["nickname"] as? String ?? "",
                                selectedPlate: data["selectedPlate"] as? String ?? "",
                                selectedFoods: data["selectedFoods"] as? [String] ?? [],
                                rotation: data["rotationOffset"] as? Double ?? 0,
                                imageURL: data["imageURL"] as? String ?? ""
                            )

                            userModel.dishes = [dish]
                            print("✅ 내 디쉬 복원 성공: \(dish.nickname)")
                        } else {
                            print("❌ 내 디쉬 불러오기 실패: \(error?.localizedDescription ?? "No data")")
                        }
                    }
                } else {
                    print("ℹ️ UserDefaults에 저장된 nickname 또는 myDishID가 없습니다.")
                }
            }

            }
        }
    }


#Preview {
    MainView()
        .environmentObject(UserModel.shared)
}

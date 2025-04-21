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
                        backgroundColor: Color.white,
                        cornerRadius: 30,
                        opacity: 0.6
                    )

                    VStack(spacing: -60) {
                        Color(red: 1, green: 0.94, blue: 0.63)
                            .frame(height: 130)
                            .ignoresSafeArea(edges: .top)

                        ScrollView {
                            ZStack(alignment: .top) {
                                CheckBackground(
                                    lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                                    backgroundColor: .white,
                                    cornerRadius: 0,
                                    opacity: 0.6
                                )
                                .frame(height: 1000)

                                FinalDishList(
                                    dishes: firestoreManager.dishes,
                                    onSelect: { dish in
                                        selectedDish = dish
                                        goToRunnerDish = true
                                        print("✅ 선택된 디쉬: \(dish.nickname)")
                                    }
                                )
                                .padding(.top, 40)
                                .offset(y:-40)
                                .background(Color.clear)
                            }
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
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                                .padding(.vertical, 3)
                                .padding(.horizontal, 18)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)

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
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50.5, height: 54)
                                    .offset(y:10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
                            }
                            .padding(.trailing, 34)
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

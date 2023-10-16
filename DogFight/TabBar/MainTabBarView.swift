//
//  MainTabBarView.swift
//  DogFight
//
//  Created by 김민기 on 2023/09/15.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case debate
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .debate:
            return "Debate"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .debate:
            return "list.dash.header.rectangle"
        }
    }
}

struct MainTabBarView: View {
    
    @EnvironmentObject var tabStore : TabStore
    
    @State var selectedTab = 0
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(Color.backgrounBlack)
        UITabBar.appearance().backgroundColor = UIColor(Color.backgrounBlack)
     
      }
    var body: some View {
            ZStack(alignment: .bottom){
           
                TabView(selection: $selectedTab) {
                        HomeView()
                            .tag(0)
                            .toolbarBackground(Color.backgrounBlack, for: .tabBar)
                        MainView()
                            .tag(1)
                            .toolbarBackground(Color.backgrounBlack, for: .tabBar)
                }
                
                
                if tabStore.isShowingTab{
                    ZStack{
                        
                        HStack{
                            ForEach((TabbedItems.allCases), id: \.self){ item in
                                Button{
                                    selectedTab = item.rawValue
                                } label: {
                                    CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                                }
                            }
                        }
                        .padding(6)
                        
                    }
                    .frame(height: 70)
                    .background(Color.listGrayColor)
                    .cornerRadius(35)
                    .padding(.horizontal, 26)
                }
            }
        }
}

extension MainTabBarView{
   

    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .white : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .white : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? UIScreen.main.bounds.width * 0.6 : 60, height: 60)
        .background(isActive ? Color.backgrounBlack : .clear).ignoresSafeArea()
        .cornerRadius(30)
    }
}

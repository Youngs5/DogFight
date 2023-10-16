//
//  CategoryScrollView.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import SwiftUI

struct CategoryScrollView: View {
    @ObservedObject var mainStore: MainStore
    @State private var selectedIndex:Int = 0
    let categories: [String] = ["All", "Food" ,"Sports", "Animal", "Stock", "Game", "etc"]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories.indices, id: \.self) { index in
                        Button {
                            selectedIndex = index
                            mainStore.categoryName = categories[index]
                            mainStore.filterCategoryList()
                            withAnimation {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        } label: {
                            Text(categories[index])
                                .categoryStyle(
                                    background: selectedIndex == index ? Color.white : Color.fieldGrayColor,
                                    foreground: selectedIndex == index ? Color.fieldGrayColor : Color.white
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}


struct CategoryScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryScrollView(mainStore: MainStore())
    }
}

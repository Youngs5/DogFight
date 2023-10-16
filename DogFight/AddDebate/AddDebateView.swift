//
//  AddDebateView.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/15.
//
import SwiftUI

struct AddDebateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var addDebateStore: AddDebateStore
    @EnvironmentObject private var tabStore: TabStore
    @State var selectedData: Category? = nil
    @State private var selectedImages: [UIImage] = []
    @State private var imageNames: [String] = []
    @State private var isPickerSelected: Bool = false
    @State private var sliderValue: Double = 1.0
    @State private var isShowingAlert: Bool = false
    
    var body: some View {
        ZStack{
            Color.backgrounBlack
                .ignoresSafeArea(.all)
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "delete.backward")
                            .foregroundColor(Color.signInWhite)
                    }
                    Spacer()
                    Text("POST")
                        .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }.padding(.horizontal, 20)

                ScrollView{
                    addDebateStore.customPadding(
                        HStack{
                            CustomTitleTextField(maxLength: 20, placeholder: "", text: $addDebateStore.debateTitle)
                            Spacer()
                        })
                    addDebateStore.customPadding(
                        HStack{
                            CustomPickerView(selectedData: $selectedData, isPickerSelected: $isPickerSelected, placeholder: "Category")
                            
                            Spacer()
                        })
                    if isPickerSelected {
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height * 0.37)
                    }
                    addDebateStore.customPadding(
                        HStack{
                            TimeSliderView(sliderValue: $sliderValue)
                        })
                    addDebateStore.customPadding(
                        HStack{
                            PhotoSelectView(selectedImages: $selectedImages, selectedImageNames: $imageNames)
                        })
                    addDebateStore.customPadding(
                        HStack{
                            CustomContentTextField(maxLength: 200, placeholder: "Content", text: $addDebateStore.debateContent)
                            Spacer()
                        })
                    addDebateStore.customPadding(
                        HStack{
                            Spacer()
                            ZStack {
                                Color.fieldGrayColor
                                    .cornerRadius(10)
                                    .frame(width: UIScreen.main.bounds.width * 0.5, height: 50)
                                Button {
                                    if isExistAllInfo() {
                                        if let selectedData = selectedData {
                                            addDebateStore.registerDebate(debateTitle: addDebateStore.debateTitle, debateContent: addDebateStore.debateContent, selectedCategory: selectedData, sliderValue: sliderValue, selectedImages: selectedImages){ error in
                                                if error == nil {
                                                    presentationMode.wrappedValue.dismiss()
                                                }
                                            }
                                        }
                                    }
                                } label : {
                                    Text("REIGSTER")
                                        .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.045))
                                        .foregroundColor(.white)
                                }
                                .alert(isPresented: $isShowingAlert) {
                                    Alert(title: Text("WARNING"), message: Text("You must enter all information"), dismissButton: .default(Text("OK")))
                                }
                            }
                            Spacer()
                        })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for:.tabBar)
        .onAppear{
            tabStore.isShowingTab = false
        }
        .onDisappear{
            tabStore.isShowingTab = true
        }
    }
    
    func isExistAllInfo() -> Bool {
        if addDebateStore.debateTitle.isEmpty || addDebateStore.debateContent.isEmpty || selectedData == nil {
            isShowingAlert.toggle()
            
            return false
        } else {
            
            return true
        }
    }
}

struct AddDebateView_Previews: PreviewProvider {
    static var previews: some View {
        AddDebateView(addDebateStore: AddDebateStore())
            .environmentObject(TabStore())
    }
}

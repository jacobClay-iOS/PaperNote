//
//  UsersTaskListCollection.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/24/22.
//

import SwiftUI

// MARK: remove background zstack and navigation view

struct UsersTaskListCollection: View {
    @StateObject var usersTaskListCollectionVM = UsersTaskListCollectionVM()
    @State var isShowingListTitleField = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NeumorphicBackground()
                VStack {
                    Text("My Lists")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(usersTaskListCollectionVM.collectionOfLists) { collectionListItem in
                                
                                NavigationLink(destination: {
                                    TaskListView(taskList: collectionListItem, taskListVM: TaskListVM(collectionListItem))
                                }, label: {
                                    ListCard(collectionListItem: collectionListItem)
                                        .padding(.horizontal, 5)
                                })
                            }
                            Button {
                                withAnimation {
                                    isShowingListTitleField.toggle()
                                }
                            } label: {
                                addListButtonLabel
                            }
                        } // end of LazyHStack
                    } // end of scrollview
                } // end of VStack
                
            }
            .navigationBarHidden(true)
            .overlay {
                if isShowingListTitleField {
                    AddListSheet(isShowingListTitleField: $isShowingListTitleField)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .environmentObject(usersTaskListCollectionVM)
    }
    
    var addListButtonLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Surface"))
                .frame(width: 120, height: 120)
                .shadow(color: Color("OuterShadow"), radius: 4, x: 2, y: 2)
                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
                .padding(.leading, 5)
            
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.primary)
        }
    }
}






struct UsersTaskListCollection_Previews: PreviewProvider {
    static var previews: some View {
        UsersTaskListCollection()
            .preferredColorScheme(.light)
    }
}

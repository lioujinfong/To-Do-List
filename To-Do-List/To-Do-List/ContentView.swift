//
//  ContentView.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var m_ToDoList: M_ToDoList
    @EnvironmentObject var viewModel: ViewModel
    @StateObject private var networkManager = NetworkManager()


    @State private var selection: String? = nil
    @State var n_list = ""
    @State var Due_Date_sort : [String] = []
    
    @State var timer: Timer? = nil
    @State var seconds: Int = 0
    
    @State private var offset: CGFloat = 0
    @State var isPopoverVisible = false

    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: Add_ToDoList(), tag: "Add_ToDoList", selection: $selection) { EmptyView() }
                
                NavigationLink(destination: Manager_ToDoList(n_list:n_list), tag: "Manager_ToDoList", selection: $selection) { EmptyView() }
                

                
                if  !viewModel.Get_Quotable_Fail || !networkManager.isConnected{
                    VStack{
                        Text("Error!!")
                        Text("Please check your Internet or API")
                    }
                } else {
                    
                    
                    
                    VStack{
                        Text("To-Do-List : \(m_ToDoList.Title.count)")
                            .font(.system(size: 25))
                            .foregroundColor(Color.red)
                            .fontWeight(.medium)
                        
                        if viewModel.quotable_M.count > 0 {
                            QuoteView()
                        }
                        
                        
                        List{
                            
                            if m_ToDoList.Title.count != 0 {
                                
                                ForEach(Due_Date_sort, id: \.self){ index in
                                    
                                    ToDoListView(key:String(index))
                                        .onTapGesture {
                                            n_list = String(index)
                                            selection = "Manager_ToDoList"
                                        }
                                }
                                .onDelete(perform: deleteItem)
                            }
                        } // List
                    }
                    
                    VStack{
                        Spacer()
                        HStack{
                            // CTA Button
                            Button(action: {
                                selection = "Add_ToDoList"
                            }) {
                                Text("Add To-Do-List")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                isPopoverVisible = true
                            }) {
                                Text("Tips")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        
                    }
                }
                
                
                
                
            } // ZStack
            .onAppear{
//                print(m_ToDoList.Device_Location["0"]!["latitude"])
//                m_ToDoList.Title.removeAll()
//                m_ToDoList.Description.removeAll()
//                m_ToDoList.Created_Date.removeAll()
//                m_ToDoList.Due_Date.removeAll()
//                m_ToDoList.Device_Location.removeAll()
                viewModel.Get_Quotable()
                
                Due_Date_sort.removeAll()
                var sortedDataByValue: [(String, Date)] {
                    m_ToDoList.Due_Date.sorted { $0.value < $1.value }
                }
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
                    if m_ToDoList.Due_Date.count != 0{

                        for (key, value) in  sortedDataByValue {
                            Due_Date_sort.append(key)
                        }
                        if Due_Date_sort.count == m_ToDoList.Due_Date.count {
                            timer?.invalidate()
                            timer = nil
                            seconds = 0
                            print(Due_Date_sort)
                        }

                        seconds += 1
                    }
                }


                
                
            }
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                PopoverView()
            }

        } // NavigationView
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        let indices = Array(offsets)
        for index in indices {
            let key = Due_Date_sort[index]
            m_ToDoList.Title.removeValue(forKey: key)
            m_ToDoList.Description.removeValue(forKey: key)
            m_ToDoList.Created_Date.removeValue(forKey: key)
            m_ToDoList.Due_Date.removeValue(forKey: key)
            m_ToDoList.Device_Location.removeValue(forKey: key)

        }
        Due_Date_sort.remove(atOffsets: offsets)

    }
    

}


struct ToDoListView: View {
    @EnvironmentObject var m_ToDoList: M_ToDoList
    var key : String?
    var body: some View {
        let Created_Date = DateToString(Date: m_ToDoList.Created_Date[key!] ?? Date())
        let Due_Date = DateToString(Date: m_ToDoList.Due_Date[key!] ?? Date())
        let lat = m_ToDoList.Device_Location[key!]?["latitude"] ?? 0.0
        let lng = m_ToDoList.Device_Location[key!]?["longitude"] ?? 0.0
        VStack{
            HStack{
                Text("Title:")
                Text(m_ToDoList.Title[key!] ?? "error")
                Spacer()
            }

            HStack{
                Text("Description:")
                Text(m_ToDoList.Description[key!] ?? "error")
                Spacer()
            }

            HStack{
                Text("Created Date:")
                Text(Created_Date)
                Spacer()
            }

            HStack{
                Text("Due Date:")
                Text(Due_Date)
                Spacer()
            }

            HStack{
                Text("Location:")
                VStack{
                    Text("\(lat)")
                    Text("\(lng)")
                }
                Spacer()

            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width*0.9)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.5)))
        .padding(5)
    }
}


struct QuoteView : View{
    @EnvironmentObject var viewModel: ViewModel
    var body: some View{
        VStack{
            HStack{
                Text("_id : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0]._id)
                Spacer()
            }
            
            HStack{
                Text("content : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0].content)
                Spacer()
            }
            
            HStack{
                Text("author : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0].author)
                Spacer()
            }
            
            HStack{
                Text("tags : ")
                    .foregroundColor(Color.blue)
                ForEach(viewModel.quotable_M[0].tags, id: \.self) { item in
                    Text(item)
                    Spacer()
                }
            }
            
            
            
            HStack{
                Text("authorSlug : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0].authorSlug)
                Spacer()
            }
            
            
            HStack{
                Text("length : ")
                    .foregroundColor(Color.blue)
                Text("\(viewModel.quotable_M[0].length)")
                Spacer()
            }
            
            HStack{
                Text("dateAdded : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0].dateAdded)
                Spacer()
            }
            
            HStack{
                Text("dateModified : ")
                    .foregroundColor(Color.blue)
                Text(viewModel.quotable_M[0].dateModified)
                Spacer()
            }
            
        }
    }
}




struct PopoverView: View {
    var body: some View {
        VStack {
            Text("Add To-Do-List")
                .font(.headline)
            
            Text("You can click Add To-Do-List Button to add")
            
            Divider()
            
            Text("Edit To-Do-List")
                .font(.headline)
            
            Text("You can click one To-Do-List item and you will see an edit button in the top right corner of the window.")
            
            Divider()
            
            Text("Delete To-Do-List")
                .font(.headline)
            
            Text("You can swipe left your To-Do-List item and you will see delete button.")
            
            Divider()
            
            
            
        }
        .padding()
    }
}

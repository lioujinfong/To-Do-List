//
//  Detail_ToDoList.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/24.
//

import SwiftUI


struct Manager_ToDoList: View {
    var n_list : String
    
    @State var edit = false
    var body: some View {
        ScrollView(.vertical){
            if edit{
                Edit_ToDoList(n_list:n_list)
            }else{
                Detail_ToDoList(n_list:n_list)
            }
        }
        .navigationTitle(self.edit ? "Edit To-Do-list" : "My To-Do-list")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.edit.toggle()
                    
                    
                }, label: {
                    Text(self.edit ? "" : "Edit")
                        .foregroundColor(Color.red)
                })
                
            }
            
            ToolbarItem(placement:.navigationBarLeading){
                Button(action: {
                    if edit {
                        self.edit.toggle()
                    }
                    
                }, label: {
                    Text(self.edit ? "Cancel" : "")
                })
            }
        }
        .navigationBarBackButtonHidden(self.edit ? true : false)
        
       
    }
}


struct Detail_ToDoList: View {
    @EnvironmentObject var m_ToDoList: M_ToDoList
    var n_list : String
    @State private var Title = ""
    @State private var Description = ""
    @State private var Created_Date = ""
    @State private var Due_Date = ""
    @State private var Latitude : String = ""
    @State private var Longitude : String = ""
    
    
    var body: some View {

        VStack{
            // Title
            HStack{
                Text("Title:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                
                
                Text(Title)
                    .font(.system(size: 25))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)



                Spacer()
            }.padding(5)
            
            // Description
            VStack{
                HStack{
                    Text("Description:")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                
                HStack{
                    Text(Description)
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(Color.green)
                    
                    Spacer()
                }
                
                
                    
                
            }.padding([.bottom,.leading,.trailing],5)
            
            // Created Date
            HStack{
                Text("Created Date: ")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                Text(Created_Date)
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .foregroundColor(Color.green)
   
                Spacer()
            }.padding()
            
            // Due Date
            HStack{
                Text("Due Date: ")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                Text(Due_Date)
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .foregroundColor(Color.green)
                Spacer()
            }.padding()
            
                


            // Device Location

            HStack{
                Text("Latitude:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                Text(Latitude)
                    .font(.system(size: 30))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)

                Spacer()
            }.padding([.bottom,.leading,.trailing],5)
            
            HStack{
                Text("Longitude:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                Text(Longitude)
                    .font(.system(size: 30))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)
 
                Spacer()
            }.padding([.bottom,.leading,.trailing],5)

            Spacer()
         
        } // VStack
        .onAppear{
            Title = m_ToDoList.Title[n_list]!
            Description = m_ToDoList.Description[n_list]!
            Created_Date = DateToString(Date: m_ToDoList.Created_Date[n_list]!)
            Due_Date = DateToString(Date: m_ToDoList.Due_Date[n_list]!)
            Latitude = String(m_ToDoList.Device_Location[n_list]!["latitude"]!)
            Longitude = String(m_ToDoList.Device_Location[n_list]!["longitude"]!)
        }
    }
}

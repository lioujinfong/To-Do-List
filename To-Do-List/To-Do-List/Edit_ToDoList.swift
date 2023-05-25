//
//  Edit_ToDoList.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/24.
//

import SwiftUI

struct Edit_ToDoList: View {
    @EnvironmentObject var m_ToDoList: M_ToDoList
    var n_list : String
    @State private var Title = ""
    @State private var Description = ""
    @State private var Created_Date = Date()
    @State private var Due_Date = Date().addingTimeInterval(60*60*24)
    @State private var Latitude : String = ""
    @State private var Longitude : String = ""
    @State var showAlert = false
    var body: some View {
        VStack{
            // Title
            HStack{
                Text("Title:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                
                
                TextField("Title",text: $Title)
                    .font(.system(size: 25))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                            .padding(.top, 25)
                    )


                
            }.padding(5)
            
            // Description
            VStack{

                HStack{
                    Text("Description")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    Spacer()
                }


                PlaceholderTextView(placeholder: "Go Home", text: $Description)
                    .frame(height: 100)
                    .border(Color.black, width: 1)
            }.padding([.bottom,.leading,.trailing],5)


            // Created Date
            DatePicker(
                "Created Date",
                selection: $Created_Date,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .padding(.top, 25)
            )
            .padding()

            // Due Date
            DatePicker(
                "Due Date",
                selection: $Due_Date,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .padding(.top, 25)
            )
            .padding()

            // Device Location

            
            
            HStack{
                Text("Latitude:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                TextField("Latitude", text:$Latitude)
                    .font(.system(size: 30))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                            .padding(.top, 25)
                    )
                
            }.padding([.bottom,.leading,.trailing],5)
            
            HStack{
                Text("Longitude:")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                TextField("Longitude", text: $Longitude)
                    .font(.system(size: 30))
                    .foregroundColor(Color.green)
                    .fontWeight(.medium)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                            .padding(.top, 25)
                    )
            }.padding([.bottom,.leading,.trailing],5)




            


            // CTA Button
            Button(action: {
                // get To-Do list count

                let device_location: [String: Double] = [
                    "latitude": Double(Latitude)!,
                    "longitude": Double(Longitude)!
                ]
                
                m_ToDoList.Title.updateValue(Title, forKey: n_list)
                m_ToDoList.Description.updateValue(Description, forKey: n_list)
                m_ToDoList.Created_Date.updateValue(Created_Date, forKey: n_list)
                m_ToDoList.Due_Date.updateValue(Due_Date, forKey: n_list)
                m_ToDoList.Device_Location.updateValue(device_location, forKey: n_list)

                showAlert = true

            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            
            Spacer()
         
        } // VStack
        .onAppear{
            Title = m_ToDoList.Title[n_list]!
            Description = m_ToDoList.Description[n_list]!
            Created_Date = m_ToDoList.Created_Date[n_list]!
            Due_Date = m_ToDoList.Due_Date[n_list]!
            Latitude = String(m_ToDoList.Device_Location[n_list]!["latitude"]!)
            Longitude = String(m_ToDoList.Device_Location[n_list]!["longitude"]!)
        }
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("Completed"),
                dismissButton: .default(Text("Got it!")){
                    NavigationUtil1.popToRootView() // 回到父視窗
                })
        }
    }
}

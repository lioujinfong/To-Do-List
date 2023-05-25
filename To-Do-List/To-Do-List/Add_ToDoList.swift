//
//  Add_ToDoList.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/23.
//

import SwiftUI
import CoreLocation

struct Add_ToDoList: View {
    @EnvironmentObject var m_ToDoList: M_ToDoList
    @StateObject var m_Location = LocationManager()
    
    @State private var Title = ""
    @State private var Description = ""
    @State private var Created_Date = Date()
    @State private var Due_Date = Date().addingTimeInterval(60*60*24)

    @State var locationManager = CLLocationManager()
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
            
            if m_Location.permissionDenied{
                
                HStack{
                    Text("Latitude:")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    TextField("Latitude", text:$m_Location.latitude)
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
                    TextField("Longitude", text: $m_Location.longitude)
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
                
                


            }
            
            
            // CTA Button
            Button(action: {
                // get Dict last key
                
                
                // get To-Do list count
                let ToDoList_Num = UUID()
                let device_location: [String: Double] = [
                    "latitude": Double(m_Location.latitude)!,
                    "longitude": Double(m_Location.longitude)!
                ]
                
                m_ToDoList.Title.updateValue(Title, forKey: "\(ToDoList_Num)")
                m_ToDoList.Description.updateValue(Description, forKey: "\(ToDoList_Num)")
                m_ToDoList.Created_Date.updateValue(Created_Date, forKey: "\(ToDoList_Num)")
                m_ToDoList.Due_Date.updateValue(Due_Date, forKey: "\(ToDoList_Num)")
                m_ToDoList.Device_Location.updateValue(device_location, forKey: "\(ToDoList_Num)")
                
                showAlert = true

            }) {
                Text("Add To-Do List")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            
            Spacer()
         
        } // VStack
        .onAppear {
            locationManager.delegate = m_Location
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
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


struct PlaceholderTextView: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $text)
                .font(.system(size: 25))
                .fontWeight(.medium)
                .foregroundColor(Color.green)
                .background(Color.clear)
            
            if text == "" {
                Text("Your description...")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}

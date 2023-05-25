//
//  ViewModel.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/25.
//

import Foundation


class ViewModel: ObservableObject{
    
    @Published var quotable_M = [Quotable_Model]()
    @Published var Get_Quotable_Fail = true
    func Get_Quotable(){
        guard let url = URL(string: "https://api.quotable.io/quotes/random") else{
            print("Not found url")
            self.Get_Quotable_Fail = false
            return
        }
        URLSession.shared.dataTask(with: url){(data,res,error) in
            if error != nil{
                print("error", error?.localizedDescription ?? "")
                return
            }
            do{
                if let data = data{
                    let result = try JSONDecoder().decode([Quotable_Model].self, from: data)
                    DispatchQueue.main.async{
                        self.Get_Quotable_Fail = true
//                        print("result : \(result)")
                        self.quotable_M = result
                        
                        print(self.quotable_M.count)
                    }
                } else {
                    self.Get_Quotable_Fail = false
                    print("No data")
                }
            } catch let JsonError{
                self.Get_Quotable_Fail = false
                print("fetchPosts => fetch json error:", JsonError.localizedDescription)
            }

        }.resume()
    }
    
    
    
}

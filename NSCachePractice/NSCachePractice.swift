//
//  NSCachePractice.swift
//  NSCachePractice
//
//  Created by Vivek Pattanaik on 6/18/21.
//

import SwiftUI


class CacheViewModel : ObservableObject {
    
    @Published var startingImage : UIImage? = nil
    let imageName : String = "tim"
    
    init (){
        
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: "")
    }
    
}

struct NSCachePractice: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack(){
                Image("tim")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    
                }
                Spacer()
            }
            .navigationTitle("Cache Practice")
        }
    }
}

struct NSCachePractice_Previews: PreviewProvider {
    static var previews: some View {
        NSCachePractice()
    }
}

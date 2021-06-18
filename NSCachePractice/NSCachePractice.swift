//
//  NSCachePractice.swift
//  NSCachePractice
//
//  Created by Vivek Pattanaik on 6/18/21.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager() // Singleton : Means it's the only instance
    private init() {} // prevents furthur inits outside class
    
    var imageCache : NSCache<NSString, UIImage>  = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100mb
        return cache
    }()
    
    func add(image : UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to Cache"
    }
    
    func remove(name : String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from Cache"
    }
    
    func get(name : String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel : ObservableObject {
    
    @Published var startingImage : UIImage? = nil
    @Published var cacheImage : UIImage? = nil
    @Published var infoMessage : String = ""
    let imageName : String = "tim"
    let manager = CacheManager.instance
    init (){
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else {return}
        infoMessage =  manager.add(image: image, name: imageName)
        
    }
    
    func deleteFromCache() {
        
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cacheImage = manager.get(name: imageName)
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
        
    }
}

struct NSCachePractice: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack(){
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.deleteFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    
                    
                    
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                if let image = vm.cacheImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
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

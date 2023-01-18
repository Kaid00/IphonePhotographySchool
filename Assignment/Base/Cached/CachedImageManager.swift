//
//  CacheImageManager.swift
//  Assignment
//
//  Created by Azamah Junior Khan on 18/01/2023.
//

import Foundation

final class CachedImageManager: ObservableObject {
    @Published private(set) var currentState: CurrentState?
    
    private let imageRetriever = ImageRetriever()
    @MainActor
    func load(_ imgUrl: String, cache: ImageCache = .shared) async {
        
        self.currentState = .loading
        
        if let imageData = cache.object(forkey: imgUrl as NSString) {
            self.currentState = .success(data: imageData)
            #if DEBUG
            print("Fetching image from the cache: \(imgUrl)")
            #endif
            return
        }
        
        do {
            let data = try await imageRetriever.fetch(imgUrl)
            self.currentState = .success(data: data)
            cache.set(object: data as NSData,
                      forkey: imgUrl as NSString)
            #if DEBUG
            print("Caching image: \(imgUrl)")
            #endif

        } catch {
            self.currentState = .failed(error: error)
        }
        
    }
}

extension CachedImageManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

extension CachedImageManager.CurrentState: Equatable {
    static func == (lhs: CachedImageManager.CurrentState,
                    rhs: CachedImageManager.CurrentState) -> Bool {
        switch (lhs, rhs){
        case (.loading, .loading):
            return true
        case (let .failed(lhsError), let .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (let .success(lhsData), let .success(rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}

//
//  Channels.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

typealias Channels = Collection<Channel>

//MARK: Computed properties
extension Channels {
    
    var allChannelNames: [String] {
        return lists.map { $0.name }
    }
      
}

//MARK: Additional functions
extension Channels {
    
}

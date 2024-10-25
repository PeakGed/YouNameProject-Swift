//
//  CapsuleVM.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//
import UIKit

struct CapsuleVM {
    let title: String
    let value: String
    let frame: CGRect
    
    init(title: String,
         value: String,
         frame: CGRect) {
        self.title = title
        self.value = value
        self.frame = frame
    }
}

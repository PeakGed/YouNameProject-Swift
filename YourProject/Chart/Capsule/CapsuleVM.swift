//
//  CapsuleVM.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//
import UIKit

struct CapsuleVM {
    let leftTitle: String
    let rightTitle: String
    let frame: CGRect
    
    init(leftTitle: String,
         rightTitle: String,
         frame: CGRect) {
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.frame = frame
    }
}

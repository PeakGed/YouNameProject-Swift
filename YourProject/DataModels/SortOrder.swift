//
//  SortOrder.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//
import Foundation

enum SortOrderBy: String {
      case ascending = "asc"
      case descending = "desc"
  }

enum ServiceSortedOrder: String, Codable {
    case ascending = "ASC"
    case descending = "DESC"
}

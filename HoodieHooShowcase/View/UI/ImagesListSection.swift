//
//  ImagesListSection.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import Foundation
import RxDataSources

struct ImagesListSection {
  let header: String
  var items: [String]
}

extension ImagesListSection: SectionModelType {
  init(original: ImagesListSection, items: [String]) {
    self = original
    self.items = items
  }
}

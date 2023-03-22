//
//  BannerInfo.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import UIKit

struct BannerInfo: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let imageURL: String?
    let image: UIImage?
    
    init(imageURL: String? = "", image: UIImage? = nil) {
        self.imageURL = imageURL
        self.image = image
    }
}

var datas: [BannerInfo] = [
    BannerInfo(imageURL: "b1",image: .homeImage1),
    BannerInfo(imageURL: "b2",image: .badminton),
    BannerInfo(imageURL: "b3",image: .all)
]

var datas2: [BannerInfo] = [
    BannerInfo(imageURL: "b4", image: .homeImage1),
    BannerInfo(imageURL: "b5", image: .badminton),
    BannerInfo(imageURL: "b6", image: .all)
]

var datas3: [BannerInfo] = [
    BannerInfo(imageURL: "b7", image: .homeImage1),
    BannerInfo(imageURL: "b8", image: .badminton),
    BannerInfo(imageURL: "b9", image: .all)
]

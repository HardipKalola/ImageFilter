//  FilterDemo
//
//  Created by Hardip Kalola on 29/09/18.
//  Copyright © 2018 Hardip Kalola. All rights reserved.

import UIKit

enum ImageFilterType: Int {
    case instant
    case fade
    case noir
    case transfer
    case chrome
    case tonal
    case process
    case vignette
    case posterize
    case blackWhite
    case rgbLinear

    static let mapper: [ImageFilterType: String] = [
        .instant : "CIPhotoEffectInstant",
        .chrome : "CIPhotoEffectChrome",
        .fade : "CIPhotoEffectFade",
        .blackWhite : "CIPhotoEffectMono",
        .noir : "CIPhotoEffectNoir",
        .process : "CIPhotoEffectProcess",
        .tonal : "CIPhotoEffectTonal",
        .transfer : "CIPhotoEffectTransfer",
        .vignette : "CIVignette",
        .posterize : "CIColorPosterize",
        .rgbLinear : "CISRGBToneCurveToLinear"
    ]
    
    var stringValue: String {
        return ImageFilterType.mapper[self]!
    }
    
    static var count: Int {
        return ImageFilterType.blackWhite.hashValue + 1
    }
}

struct ImageCIFilters {
    
    var inputImage: CIImage?
    var filter: CIFilter!
    var filterKey: String!
    
    init(filterType type: ImageFilterType) {
        filterKey = type.stringValue
        filter = CIFilter(name: filterKey)!
    }
    
    //Get Filtered Image
    func outputFilteredImage() -> CIImage? {
        if let img = inputImage {
            filter.setValue(img, forKey: kCIInputImageKey)
            return filter.outputImage
        }
        return nil
    }
}

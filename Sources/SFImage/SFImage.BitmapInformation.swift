import FreeImage

public extension SFImage {
    
    var imageType: SFImageType {
        let type = FreeImage_GetImageType(imgPointer)
        return SFImageType(rawValue: type) ?? .unknown
    }

    var bitsPerPixel: Int {
        return Int(FreeImage_GetBPP(imgPointer))
    }

    var width: Int {
        return Int(FreeImage_GetWidth(imgPointer))
    }

    var height: Int {
        return Int(FreeImage_GetHeight(imgPointer))
    }

    var pitch: Int {
        return Int(FreeImage_GetPitch(imgPointer))
    }

}
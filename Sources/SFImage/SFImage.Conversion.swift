import FreeImage

/**
 Conversion
 */
public extension SFImage {

    @discardableResult
    mutating func convert(to type: SFImageType, 
                          scaleLinear: Bool = true) -> Bool {

        guard imageType != type else {
            return true
        }

        guard let imgPointer = FreeImage_ConvertToType(imgPointer, 
                                                       type.rawValue,
                                                       scaleLinear ? 1 : 0) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)
        
        return true
    }

}

 
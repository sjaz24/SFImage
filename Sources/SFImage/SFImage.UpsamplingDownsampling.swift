import FreeImage

/**
 Upsampling and Downsampling
 */
public extension SFImage {

    @discardableResult
    mutating func rescale(to size: (width: Int, height: Int), 
                           filter: SFImageFilter = .catmullrom) -> Bool {

        guard let imgPointer = FreeImage_Rescale(imgPointer, 
                                                 Int32(size.width), 
                                                 Int32(size.height), 
                                                 filter.rawValue) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)

        return true
    }

    @discardableResult
    mutating func rescaleRect(_ rect: (top: Int, left: Int, bottom: Int, right: Int),
                             to size: (width: Int, height: Int),
                              filter: SFImageFilter = .catmullrom) -> Bool {

        guard let imgPointer = FreeImage_RescaleRect(imgPointer,
                                                     Int32(size.width),
                                                     Int32(size.height),
                                                     Int32(rect.left),
                                                     Int32(rect.top),
                                                     Int32(rect.right),
                                                     Int32(rect.bottom),
                                                     filter.rawValue,
                                                     0) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)
        
        return true
    }

 }

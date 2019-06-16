import FreeImage

/**
 Rotation and Flipping
 */
public extension SFImage {

    @discardableResult
    mutating func rotate(degrees: Double) -> Bool {

        guard let imgPointer = FreeImage_Rotate(imgPointer, 
                                                degrees, 
                                                nil) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)

        return true
    }

    @discardableResult
    mutating func rotateEx(degrees: Double = 0.0, 
                            origin: (x: Double, y: Double)? = nil, 
                             shift: (x: Double, y: Double) = (0.0, 0.0), 
                              mask: Bool = false) -> Bool {
                                  
        var origin: (x: Double, y: Double)! = origin
        if origin == nil {
            origin = (Double(width) / 2.0, Double(height) / 2.0)
        }

        guard let imgPointer = FreeImage_RotateEx(imgPointer, 
                                                  degrees, 
                                                  shift.x, 
                                                  shift.y,
                                                  origin.x, 
                                                  origin.y,
                                                  mask ? 1 : 0) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)

        return true
    }   

    @discardableResult
    mutating func flipHorizontal() -> Bool {

        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_FlipHorizontal(imgPointer)

        return result != 0    
    }

    @discardableResult
    mutating func flipVertical() -> Bool {
        
        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_FlipVertical(imgPointer)

        return result != 0    
    }

}

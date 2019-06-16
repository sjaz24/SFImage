import FreeImage

/**
 Paste Access
 */
public extension SFImage {

    @discardableResult
    mutating func cut(to rectangle: (top: Int, left: Int, bottom: Int, right: Int)) -> Bool {
        
        guard let imgPointer = FreeImage_Copy(imgPointer, 
                                              Int32(rectangle.left),
                                              Int32(rectangle.top),
                                              Int32(rectangle.right),
                                              Int32(rectangle.bottom)) else {
            return false
        }

        imageRef = SFImageRef(imgPointer: imgPointer)

        return true
    }

    @discardableResult
    mutating func paste(image src: SFImage, 
                      at position: (top: Int, left: Int) = (0, 0),
                            alpha: Int = 127) -> Bool {
                                
        guard copyOnWrite() else {
            return false
        }
        
        let result = FreeImage_Paste(imgPointer, 
                                     src.imgPointer, 
                                     Int32(position.top), 
                                     Int32(position.left), 
                                     Int32(alpha))

        return result != 0
    }

}
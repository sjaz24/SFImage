import FreeImage

public class SFImageRef {

    public let imgPointer: UnsafeMutablePointer<FIBITMAP>

    init(imgPointer: UnsafeMutablePointer<FIBITMAP>) {
        self.imgPointer = imgPointer
    }

    deinit {
        FreeImage_Unload(imgPointer)
    }

}


public struct SFImage {
     
    public var imageRef: SFImageRef

    public internal(set) var format: SFImageFormat

    var imgPointer: UnsafeMutablePointer<FIBITMAP> {
        return imageRef.imgPointer
    }

    mutating func copyOnWrite() -> Bool {

        if (!isKnownUniquelyReferenced(&imageRef)) {
            guard let clone = FreeImage_Clone(imgPointer) else {
                return false
            }
            imageRef = SFImageRef(imgPointer: clone)
        }
        
        return true
    }

}

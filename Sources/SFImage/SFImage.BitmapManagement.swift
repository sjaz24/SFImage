import FreeImage

public extension SFImage {

    init?(file: String, 
        format: SFImageFormat? = nil,
         flags: Int = 0) {
             
        precondition(flags == 0 || format != nil, 
                     "Format must be specified when flags are specified.")

        let fifUnknown = Int32(FIF_UNKNOWN.rawValue)
        var freeImageFormat = fifUnknown
        if let format = format {
            freeImageFormat = format.rawValue
        } else {
            // no format specified; try to get it be reading header
            freeImageFormat = FreeImage_GetFileType(file, 0)
            if freeImageFormat == fifUnknown {
                // couldn't get format from header, try getting it from filename
                freeImageFormat = FreeImage_GetFIFFromFilename(file)
            }
        }

        guard freeImageFormat != fifUnknown,
              FreeImage_FIFSupportsReading(freeImageFormat) != 0,
              let imgPointer = FreeImage_Load(freeImageFormat, 
                                              file, 
                                              Int32(flags)) else {
            return nil
        }
        
        imageRef = SFImageRef(imgPointer: imgPointer)
        self.format = SFImageFormat(rawValue: freeImageFormat) ?? .unknown
    }
    
    @discardableResult
    func save(to file: String, 
            as format: SFImageFormat? = nil,
                flags: Int = 0) -> Bool {

        precondition(flags == 0 || format != nil, 
                     "Format must be specified when flag is specified.")

        let freeImageFormat: Int32
        if let format = format {
            freeImageFormat = format.rawValue
        } else {
            // no format specified; try to get it from filename
            freeImageFormat = FreeImage_GetFIFFromFilename(file)
        }

        guard freeImageFormat != Int32(FIF_UNKNOWN.rawValue) else {
            return false
        }
        
        let imageType = FreeImage_GetImageType(imgPointer);
        let canSave: Bool
        if imageType == Int32(FIT_BITMAP.rawValue) {
            let bitsPerPixel = Int32(FreeImage_GetBPP(imgPointer))
            canSave = FreeImage_FIFSupportsWriting(freeImageFormat) != 0 &&
                      FreeImage_FIFSupportsExportBPP(freeImageFormat, 
                                                     bitsPerPixel) != 0
        } else {
            canSave = FreeImage_FIFSupportsExportType(freeImageFormat, 
                                                      imageType) != 0
        }

        guard canSave else {
            return false
        }

        let result = FreeImage_Save(freeImageFormat, 
                                    imgPointer, 
                                    file, 
                                    Int32(flags))

        return result != 0
    }

}
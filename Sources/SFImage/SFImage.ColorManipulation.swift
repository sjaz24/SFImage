import FreeImage

/**
  Color Manipulation
  */
public extension SFImage {

    @discardableResult
    mutating func adjustGamma(gamma: Double) -> Bool {
        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_AdjustGamma(imgPointer, 
                                           gamma)

        return result != 0
    }

    @discardableResult
    mutating func adjustBrightness(percentage: Double) -> Bool {
        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_AdjustBrightness(imgPointer, 
                                                percentage)

        return result != 0
    }

    @discardableResult
    mutating func adjustContrast(percentage: Double) -> Bool {
        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_AdjustContrast(imgPointer, 
                                              percentage)

        return result != 0
    }

    @discardableResult
    mutating func invert() -> Bool {
        guard copyOnWrite() else {
            return false
        }

        let result = FreeImage_Invert(imgPointer)

        return result != 0
    }

    @discardableResult
    mutating func adjustColors(brightness: Double = 0.0, 
                                        contrast: Double = 0.0, 
                                           gamma: Double = 0.0, 
                                          invert: Bool = false) -> Bool {
        guard copyOnWrite() else {
            return false
        }
        
        let result = FreeImage_AdjustColors(imgPointer, 
                                            brightness, 
                                            contrast, 
                                            gamma, 
                                            invert ? 1 : 0)

        return result != 0       
    }

}
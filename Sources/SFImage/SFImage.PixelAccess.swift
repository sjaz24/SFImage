import FreeImage

/**
 Pixel Access
 */
public extension SFImage {

    func getPixelColor(at coordinate: (x: Int, y: Int),
                            inverted: Bool = true) -> (red: Int, green: Int, blue: Int, alpha: Int)? {

        var color = RGBQUAD(rgbBlue: 0, 
                            rgbGreen: 0, 
                            rgbRed: 0, 
                            rgbReserved: 0)

        var coordinate = coordinate
        if inverted {
            coordinate.y = height - 1 - coordinate.y
        }

        guard FreeImage_GetPixelColor(imgPointer, 
                                      UInt32(coordinate.x), 
                                      UInt32(coordinate.y), 
                                      &color) != 0 else {
            return nil
        }

        return (red: Int(color.rgbRed), 
                green: Int(color.rgbGreen), 
                blue: Int(color.rgbBlue), 
                alpha: Int(color.rgbReserved))
    }

    @discardableResult
    mutating func setPixelColor(_ color: (red: Int, green: Int, blue: Int, alpha: Int), 
                          at coordinate: (x: Int, y: Int),
                               inverted: Bool = true) -> Bool {

        guard copyOnWrite() else {
            return false
        }

        var coordinate = coordinate
        if inverted {
            coordinate.y = height - 1 - coordinate.y
        }

        var rgbQuad = RGBQUAD(rgbBlue: UInt8(color.blue), 
                             rgbGreen: UInt8(color.green), 
                               rgbRed: UInt8(color.red), 
                          rgbReserved: UInt8(color.alpha))

        let result = FreeImage_SetPixelColor(imgPointer,
                                             UInt32(coordinate.x),
                                             UInt32(coordinate.y),
                                             &rgbQuad)

        return result != 0
    }

}
import FreeImage

/**
 Extraction
 */
public extension SFImage {

    func getFlattenedAsFloat(with normalization: (mean: [Float], std: [Float]?)? = nil,
                                    ignoreAlpha: Bool = true) -> [Float] {

        let imageType = self.imageType
        precondition(imageType == .rgbf || imageType == .rgbaf || imageType == .float)

        var norm: (mean: [Float], std: [Float]) = ([0, 0, 0], [1, 1, 1])
        if let normalization = normalization {
            let normCount = imageType == .float ? 1 : 3

            guard normalization.mean.count == normCount else {
                preconditionFailure()
            }
            norm.mean = normalization.mean

            if let std = normalization.std {
                guard std.count == normCount, !std.contains(0) else {
                    preconditionFailure()
                }
                norm.std = std
            }
        }

        let (width, height, pitch) = (self.width, self.height, self.pitch)
        let numPixels = width * height
        let (greenOffset, blueOffset, alphaOffset) = (numPixels, 2 * numPixels, 3 * numPixels)
        let componentsPerPixel = bitsPerPixel / 32
        let componentsPerLine = componentsPerPixel * width
        let includeAlpha = !ignoreAlpha && componentsPerPixel == 4
        let finalComponentsPerPixel = componentsPerPixel - (imageType == .rgbaf && !includeAlpha ? 1 : 0)
        let finalTotalComponents = finalComponentsPerPixel * numPixels
        let isRGBImage = imageType == .rgbf || imageType == .rgbaf

        var components = [Float](repeating: 0, count: finalTotalComponents)

        if var bytePointer = FreeImage_GetBits(imgPointer) {
            bytePointer += ((height - 1) * pitch)
            var index = 0
            for _ in 0..<height {
                bytePointer.withMemoryRebound(to: Float.self, capacity: componentsPerLine) {
                    (floatPointer: UnsafeMutablePointer<Float>) in
                    var floatPointer = floatPointer
                    for _ in 0..<width {
                        let redOrGray = (floatPointer[0] - norm.mean[0]) / norm.std[0]
                        components[index] = redOrGray

                        if isRGBImage {
                            let green = (floatPointer[1] - norm.mean[1]) / norm.std[1]
                            components[index + greenOffset] = green

                            let blue = (floatPointer[2] - norm.mean[2]) / norm.std[2]
                            components[index + blueOffset] = blue

                            if includeAlpha {
                                components[index + alphaOffset] = floatPointer[3]
                            }
                        }

                        floatPointer += componentsPerPixel;
                        index += 1
                    }    
                }
                bytePointer -= pitch;
            }
        }
        
        return components       
    }

    func getFlattenedAsUInt8(ignoreAlpha: Bool = true) -> [UInt8] {
        
        precondition(imageType == .bitmap && 
                     (bitsPerPixel == 8 || bitsPerPixel == 24 || bitsPerPixel == 32))

        let (width, height, pitch) = (self.width, self.height, self.pitch)
        let numPixels = width * height
        let (greenOffset, blueOffset, alphaOffset) = (numPixels, 2 * numPixels, 3 * numPixels)
        let componentsPerPixel = bitsPerPixel / 8
        let includeAlpha = !ignoreAlpha && componentsPerPixel == 4
        let finalComponentsPerPixel = componentsPerPixel - (bitsPerPixel == 32 && includeAlpha ? 0 : 1)
        let finalTotalComponents = finalComponentsPerPixel * numPixels
        let isRGBImage = bitsPerPixel == 24 || bitsPerPixel == 32

        var components = [UInt8](repeating: 0, count: finalTotalComponents)
        
        if var bytePointer = FreeImage_GetBits(imgPointer) {
            bytePointer += ((height - 1) * pitch)
            var index = 0
            for _ in 0..<height {
                var pixelPtr = bytePointer
                for _ in 0..<width {
                    components[index] = pixelPtr[Int(FI_RGBA_RED)]

                    if isRGBImage {
                        components[index + greenOffset] = pixelPtr[Int(FI_RGBA_GREEN)]
                        components[index + blueOffset] =  pixelPtr[Int(FI_RGBA_BLUE)]
                        if includeAlpha {
                            components[index + alphaOffset] = pixelPtr[3]
                        }
                    }

                    pixelPtr += componentsPerPixel;
                    index += 1
                }
                bytePointer -= pitch;
            }
        }

        return components       
    }

}
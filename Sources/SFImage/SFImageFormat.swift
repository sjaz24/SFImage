import FreeImage

public enum SFImageFormat {
    case unknown
    case bmp
    case jpeg
    case png
    case tiff
}

extension SFImageFormat: RawRepresentable {

    public init?(rawValue: Int32) {
        switch rawValue {
        case Int32(FIF_UNKNOWN.rawValue): self = .unknown
        case Int32(FIF_BMP.rawValue): self = .bmp
        case Int32(FIF_JPEG.rawValue): self = .jpeg
        case Int32(FIF_PNG.rawValue): self = .png
        case Int32(FIF_TIFF.rawValue): self = .tiff
        default: return nil
        }
    }

    public var rawValue: Int32 {
        switch self {
        case .unknown: return Int32(FIF_UNKNOWN.rawValue)
        case .bmp: return Int32(FIF_BMP.rawValue)
        case .jpeg: return Int32(FIF_JPEG.rawValue)
        case .png: return Int32(FIF_PNG.rawValue)
        case .tiff: return Int32(FIF_TIFF.rawValue)
        }
    }
    
}
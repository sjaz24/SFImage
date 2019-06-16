import FreeImage

public enum SFImageType {
    case unknown
    case bitmap
    case uint16
    case int16
    case uint32
    case int32
    case float
    case double
    case complex
    case rgb16
    case rgba16
    case rgbf
    case rgbaf
}

extension SFImageType: RawRepresentable {

    public init?(rawValue: Int32) {
        switch rawValue {
        case Int32(FIT_UNKNOWN.rawValue): self = .unknown
        case Int32(FIT_BITMAP.rawValue): self = .bitmap
        case Int32(FIT_UINT16.rawValue): self = .uint16
        case Int32(FIT_INT16.rawValue): self = .int16
        case Int32(FIT_UINT32.rawValue): self = .uint32
        case Int32(FIT_INT32.rawValue): self = .int32
        case Int32(FIT_FLOAT.rawValue): self = .float
        case Int32(FIT_DOUBLE.rawValue): self = .double
        case Int32(FIT_COMPLEX.rawValue): self = .complex
        case Int32(FIT_RGB16.rawValue): self = .rgb16
        case Int32(FIT_RGBA16.rawValue): self = .rgba16
        case Int32(FIT_RGBF.rawValue): self = .rgbf
        case Int32(FIT_RGBAF.rawValue): self = .rgbaf
        default: return nil
        }
    }

    public var rawValue: Int32 {
        switch self {
        case .unknown: return Int32(FIT_UNKNOWN.rawValue)
        case .bitmap: return Int32(FIT_BITMAP.rawValue)
        case .uint16: return Int32(FIT_UINT16.rawValue)
        case .int16: return Int32(FIT_INT16.rawValue)
        case .uint32: return Int32(FIT_UINT32.rawValue)
        case .int32: return Int32(FIT_INT32.rawValue)
        case .float: return Int32(FIT_FLOAT.rawValue)
        case .double: return Int32(FIT_DOUBLE.rawValue)
        case .complex: return Int32(FIT_COMPLEX.rawValue)
        case .rgb16: return Int32(FIT_RGB16.rawValue)
        case .rgba16: return Int32(FIT_RGBA16.rawValue)
        case .rgbf: return Int32(FIT_RGBF.rawValue)
        case .rgbaf: return Int32(FIT_RGBAF.rawValue)
        }
    }

}
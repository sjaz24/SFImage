import FreeImage

public enum SFImageFilter {
    case box
    case bilinear
    case bspline
    case bicubic
    case catmullrom
    case lanczos3
}

extension SFImageFilter: RawRepresentable {

    public init?(rawValue: Int32) {
        switch rawValue {
        case Int32(FILTER_BOX.rawValue): self = .box
        case Int32(FILTER_BILINEAR.rawValue): self = .bilinear
        case Int32(FILTER_BSPLINE.rawValue): self = .bspline
        case Int32(FILTER_BICUBIC.rawValue): self = .bicubic
        case Int32(FILTER_CATMULLROM.rawValue): self = .catmullrom
        case Int32(FILTER_LANCZOS3.rawValue): self = .lanczos3
        default: return nil
        }
    }

    public var rawValue: Int32 {
        switch self {
        case .box: return Int32(FILTER_BOX.rawValue)
        case .bilinear: return Int32(FILTER_BILINEAR.rawValue)
        case .bspline: return Int32(FILTER_BSPLINE.rawValue)
        case .bicubic: return Int32(FILTER_BICUBIC.rawValue)
        case .catmullrom: return Int32(FILTER_CATMULLROM.rawValue)
        case .lanczos3: return Int32(FILTER_LANCZOS3.rawValue)
        }
    }
    
}
import SwiftUI

// used for navigationStack in contentView() to provide navigation destination reference in navigationLink
// then navigationDestination in contentView() uses the reference and links to a specific view
enum navDestination: Hashable {
    case addWord
}

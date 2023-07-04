import SwiftUI

public struct SearchField: View {
    
    private var title: String
    private var text: Binding<String>
    private var attributedText: AttributedString {
        var res = AttributedString(text.wrappedValue)
        
        let ranges = qualifiers.values.flatMap { q in
            let regex = try! NSRegularExpression(pattern: "\(q.keyword):(\\w*)")
            let range = NSRange(location: 0, length: text.wrappedValue.count)
            let matches = regex.matches(in: text.wrappedValue, range: range)
            
            return matches.map { ($0.range(at: 1), q.attributes) }
        }
        
        for (range, attributes) in ranges {
            let body = AttributedString(text.wrappedValue[range], attributes: attributes)
            let start = res.index(res.startIndex, offsetByCharacters: range.location)
            let end = res.index(start, offsetByCharacters: range.length)
            let head = AttributedString(res[res.startIndex..<start])
            let tail = AttributedString(res[end..<res.endIndex])
            res = head + body + tail
        }
        
        return res
    }
    
    @Environment(\.qualifiers) private var qualifiers
    
    @State private var textWidth: CGFloat = 0

    public var body: some View {
        GeometryReader { geo in
            TextField(title, text: text)
                .foregroundColor(.clear)
                .overlay(alignment: geo.size.width > textWidth ? .leading : .trailing) {
                    Text(attributedText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .lineLimit(1)
                        .truncationMode(.head)
                        .fixedSize()
                        .background(sizeBackground())
                }
                .clipped()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder private func sizeBackground() -> some View {
        GeometryReader { geo in
            Color.clear
                .onChange(of: geo.size) { newValue in
                    textWidth = newValue.width
                }
            
        }
    }
    
    public init<S>(_ title: S, text: Binding<String>) where S : StringProtocol {
        self.title = String(title)
        self.text = text
    }
    
}

extension View {
    
    public func qualifier(_ keyword: String, attributes: AttributeContainer) -> some View {
        let qualifier = Qualifier(keyword: keyword, attributes: attributes)
        return modifier(qualifier)
    }
    
    public func qualifier(_ keyword: String, foregroundColor: Color? = nil, backgroundColor: Color? = nil) -> some View {
        var attributes = AttributeContainer()
        attributes.foregroundColor = foregroundColor
        attributes.backgroundColor = backgroundColor
        
        return qualifier(keyword, attributes: attributes)
    }
    
    public func qualifier(_ keyword: String, foregroundColor: Color, backgroundOpacity: Double = 0.2) -> some View {
        let backgroundColor = foregroundColor.opacity(backgroundOpacity)
        return qualifier(keyword, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
    }
    
}

extension String {
    
    subscript(range: NSRange) -> String {
        let start = range.location
        let end = start + range.length
        return String(self[start..<end])
    }

    subscript(bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    @State static private var searchQuery = "lang:Swift author:lbrndnr"
    
    static var previews: some View {
        SearchField("􀊫 Search", text: $searchQuery)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 250)
            .qualifier("lang", foregroundColor: .blue)
            .qualifier("author", foregroundColor: .green)
    }
    
}


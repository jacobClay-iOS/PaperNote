//
//  FontManager.swift
//  ToDo1
//
//  Created by Jacob Clay on 1/31/22.
//

import SwiftUI

struct FontManager {
    struct RedHat {
        static let regular = "RedHatText-Regular"
        static let regularItalic = "RedHatText-Italic"
        static let light = "RedHatText-Light"
        static let lightItalic = "RedHatText-LightItalic"
        static let bold = "RedHatText-SemiBold"
        static let boldItalic = "RedHatText-SemiBoldItalic"
    }
}

// MARK: Body Fonts
struct BodyRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyRegular() -> some View {
        modifier(BodyRegular())
    }
}

struct BodyRegularItalic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regularItalic, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyRegularItalic() -> some View {
        modifier(BodyRegularItalic())
    }
}

struct BodyLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyLight() -> some View {
        modifier(BodyLight())
    }
}

struct BodyLightItalic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.lightItalic, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyLightItalic() -> some View {
        modifier(BodyLightItalic())
    }
}

struct BodyBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyBold() -> some View {
        modifier(BodyBold())
    }
}

struct BodyBoldItalic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.boldItalic, size: 17, relativeTo: .body))
    }
}
extension View {
    func customFontBodyBoldItalic() -> some View {
        modifier(BodyBoldItalic())
    }
}

// MARK: StrikeThrough
struct BodyRegularStrikeThrough: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 17, relativeTo: .body))
            .foregroundColor(.secondary)
            .overlay(
                Rectangle()
                    .frame(height: 1, alignment: .center)
                    .foregroundColor(.secondary)
                    .offset(y: 2)
            )
    }
}
extension View {
    func customFontBodyRegularStrikethrough() -> some View {
        modifier(BodyRegularStrikeThrough())
    }
}


// MARK: Caption
struct CaptionRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 12, relativeTo: .caption))
    }
}
extension View {
    func customFontCaptionRegular() -> some View {
        modifier(CaptionRegular())
    }
}

struct CaptionBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 12, relativeTo: .caption))
    }
}
extension View {
    func customFontCaptionBold() -> some View {
        modifier(CaptionBold())
    }
}

struct CaptionLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 12, relativeTo: .caption))
    }
}
extension View {
    func customFontCaptionLight() -> some View {
        modifier(CaptionLight())
    }
}



// MARK: Headline
struct HeadlineRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 18, relativeTo: .headline))
    }
}
extension View {
    func customFontHeadline() -> some View {
        modifier(HeadlineRegular())
    }
}

struct HeadlineItalic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.boldItalic, size: 18, relativeTo: .headline))
    }
}
extension View {
    func customFontHeadlineItalic() -> some View {
        modifier(HeadlineItalic())
    }
}


// MARK: LargeTitle
struct LargeTitleRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 32, relativeTo: .largeTitle))
    }
}
extension View {
    func customFontLargeTitleRegular() -> some View {
        modifier(LargeTitleRegular())
    }
}

struct LargeTitleBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 32, relativeTo: .largeTitle))
    }
}
extension View {
    func customFontLargeTitleBold() -> some View {
        modifier(LargeTitleBold())
    }
}

struct LargeTitleLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 32, relativeTo: .largeTitle))
    }
}
extension View {
    func customFontLargeTitleLight() -> some View {
        modifier(LargeTitleLight())
    }
}


// MARK: Title
struct TitleRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 27, relativeTo: .title))
    }
}
extension View {
    func customFontTitleRegular() -> some View {
        modifier(TitleRegular())
    }
}

struct TitleBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 27, relativeTo: .title))
    }
}
extension View {
    func customFontTitleBold() -> some View {
        modifier(TitleBold())
    }
}

struct TitleLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 27, relativeTo: .title))
    }
}
extension View {
    func customFontTitleLight() -> some View {
        modifier(TitleLight())
    }
}



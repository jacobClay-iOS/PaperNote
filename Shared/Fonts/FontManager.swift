//
//  FontManager.swift
//  ToDo1
//
//  Created by Jacob Clay on 1/31/22.
//

import SwiftUI

struct FontManager {
    struct RedHat {
        static let regular = "RedHatText-Medium"
        static let regularItalic = "RedHatText-MediumItalic"
        static let light = "RedHatText-Light"
        static let lightItalic = "RedHatText-LightItalic"
        static let bold = "RedHatText-Bold"
        static let boldItalic = "RedHatText-BoldItalic"
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


// MARK: Title2
struct Title2Regular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 21, relativeTo: .title2))
    }
}
extension View {
    func customFontTitle2Regular() -> some View {
        modifier(Title2Regular())
    }
}

struct Title2Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 21, relativeTo: .title2))
    }
}
extension View {
    func customFontTitle2Bold() -> some View {
        modifier(Title2Bold())
    }
}

struct Title2Light: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 21, relativeTo: .title2))
    }
}
extension View {
    func customFontTitle2Light() -> some View {
        modifier(Title2Light())
    }
}


// MARK: Title3
struct Title3Regular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.regular, size: 19, relativeTo: .title3))
    }
}
extension View {
    func customFontTitle3Regular() -> some View {
        modifier(Title3Regular())
    }
}

struct Title3Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.bold, size: 19, relativeTo: .title3))
    }
}
extension View {
    func customFontTitle3Bold() -> some View {
        modifier(Title3Bold())
    }
}

struct Title3Light: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(FontManager.RedHat.light, size: 19, relativeTo: .title3))
    }
}
extension View {
    func customFontTitle3Light() -> some View {
        modifier(Title3Light())
    }
}

//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 7 storyboards.
  struct storyboard {
    /// Storyboard `AddEditFeedViewController`.
    static let addEditFeedViewController = _R.storyboard.addEditFeedViewController()
    /// Storyboard `AddEditFolderViewController`.
    static let addEditFolderViewController = _R.storyboard.addEditFolderViewController()
    /// Storyboard `FeedsViewController`.
    static let feedsViewController = _R.storyboard.feedsViewController()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `NewsDetailsViewController`.
    static let newsDetailsViewController = _R.storyboard.newsDetailsViewController()
    /// Storyboard `NewsFilterViewController`.
    static let newsFilterViewController = _R.storyboard.newsFilterViewController()
    /// Storyboard `NewsViewController`.
    static let newsViewController = _R.storyboard.newsViewController()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "AddEditFeedViewController", bundle: ...)`
    static func addEditFeedViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.addEditFeedViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "AddEditFolderViewController", bundle: ...)`
    static func addEditFolderViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.addEditFolderViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "FeedsViewController", bundle: ...)`
    static func feedsViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.feedsViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "NewsDetailsViewController", bundle: ...)`
    static func newsDetailsViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.newsDetailsViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "NewsFilterViewController", bundle: ...)`
    static func newsFilterViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.newsFilterViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "NewsViewController", bundle: ...)`
    static func newsViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.newsViewController)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `no-image`.
    static let noImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "no-image")
    /// Image `rss-icon`.
    static let rssIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "rss-icon")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "no-image", bundle: ..., traitCollection: ...)`
    static func noImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.noImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "rss-icon", bundle: ..., traitCollection: ...)`
    static func rssIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.rssIcon, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "FeedsViewController"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `NewsTableViewCell`.
    static let newsTableViewCell = _R.nib._NewsTableViewCell()
    /// Nib `TableViewHeaderCell`.
    static let tableViewHeaderCell = _R.nib._TableViewHeaderCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "NewsTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsTableViewCell) instead")
    static func newsTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TableViewHeaderCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.tableViewHeaderCell) instead")
    static func tableViewHeaderCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.tableViewHeaderCell)
    }
    #endif

    static func newsTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsTableViewCell? {
      return R.nib.newsTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsTableViewCell
    }

    static func tableViewHeaderCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TableViewHeaderCell? {
      return R.nib.tableViewHeaderCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TableViewHeaderCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 6 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `categoryCell`.
    static let categoryCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "categoryCell")
    /// Reuse identifier `feedCell`.
    static let feedCell: Rswift.ReuseIdentifier<FeedTableViewCell> = Rswift.ReuseIdentifier(identifier: "feedCell")
    /// Reuse identifier `feedInFolderCell`.
    static let feedInFolderCell: Rswift.ReuseIdentifier<FeedsTableViewCell> = Rswift.ReuseIdentifier(identifier: "feedInFolderCell")
    /// Reuse identifier `filterCell`.
    static let filterCell: Rswift.ReuseIdentifier<FilterTableViewCell> = Rswift.ReuseIdentifier(identifier: "filterCell")
    /// Reuse identifier `freeFeedCell`.
    static let freeFeedCell: Rswift.ReuseIdentifier<FeedsTableViewCell> = Rswift.ReuseIdentifier(identifier: "freeFeedCell")
    /// Reuse identifier `newsCell`.
    static let newsCell: Rswift.ReuseIdentifier<NewsTableViewCell> = Rswift.ReuseIdentifier(identifier: "newsCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 20 localization keys.
    struct localizable {
      /// Value: All feeds in this folder will be deleted as well
      static let deleteFolderMsg = Rswift.StringResource(key: "DeleteFolderMsg", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Are you sure?
      static let deleteFolderTitle = Rswift.StringResource(key: "DeleteFolderTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Cancel
      static let cancelLabel = Rswift.StringResource(key: "CancelLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Close
      static let closeLabel = Rswift.StringResource(key: "CloseLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Delete
      static let deleteLabel = Rswift.StringResource(key: "DeleteLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Edit
      static let editLabel = Rswift.StringResource(key: "EditLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Filter
      static let filterLabel = Rswift.StringResource(key: "FilterLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Folder name is required
      static let folderNameValidationMsg = Rswift.StringResource(key: "FolderNameValidationMsg", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Invalid URL. Please, provide  valid direct url to RSS feeds
      static let urlError = Rswift.StringResource(key: "UrlError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Link is corrupted or empry, unable to open link
      static let linkValidationMsg = Rswift.StringResource(key: "LinkValidationMsg", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Mark as read
      static let markAsRead = Rswift.StringResource(key: "MarkAsRead", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Mark as unread
      static let markAsUnread = Rswift.StringResource(key: "MarkAsUnread", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Network error. Please, try again
      static let networkError = Rswift.StringResource(key: "NetworkError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: No categories
      static let noCategoriesPlaceholcer = Rswift.StringResource(key: "NoCategoriesPlaceholcer", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: No feeds found. Tap '+' to add new rss feed.
      static let noFeedsPlaceholder = Rswift.StringResource(key: "NoFeedsPlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let okLabel = Rswift.StringResource(key: "OkLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Oops!
      static let folderNameValidationTitle = Rswift.StringResource(key: "FolderNameValidationTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Reset
      static let resetLabel = Rswift.StringResource(key: "ResetLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Unable to proceed
      static let linkValidationTitle = Rswift.StringResource(key: "LinkValidationTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Unable to read RSS. Make sure valid URL provided
      static let parsingError = Rswift.StringResource(key: "ParsingError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: All feeds in this folder will be deleted as well
      static func deleteFolderMsg(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("DeleteFolderMsg", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "DeleteFolderMsg"
        }

        return NSLocalizedString("DeleteFolderMsg", bundle: bundle, comment: "")
      }

      /// Value: Are you sure?
      static func deleteFolderTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("DeleteFolderTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "DeleteFolderTitle"
        }

        return NSLocalizedString("DeleteFolderTitle", bundle: bundle, comment: "")
      }

      /// Value: Cancel
      static func cancelLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("CancelLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "CancelLabel"
        }

        return NSLocalizedString("CancelLabel", bundle: bundle, comment: "")
      }

      /// Value: Close
      static func closeLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("CloseLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "CloseLabel"
        }

        return NSLocalizedString("CloseLabel", bundle: bundle, comment: "")
      }

      /// Value: Delete
      static func deleteLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("DeleteLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "DeleteLabel"
        }

        return NSLocalizedString("DeleteLabel", bundle: bundle, comment: "")
      }

      /// Value: Edit
      static func editLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("EditLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "EditLabel"
        }

        return NSLocalizedString("EditLabel", bundle: bundle, comment: "")
      }

      /// Value: Filter
      static func filterLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("FilterLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "FilterLabel"
        }

        return NSLocalizedString("FilterLabel", bundle: bundle, comment: "")
      }

      /// Value: Folder name is required
      static func folderNameValidationMsg(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("FolderNameValidationMsg", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "FolderNameValidationMsg"
        }

        return NSLocalizedString("FolderNameValidationMsg", bundle: bundle, comment: "")
      }

      /// Value: Invalid URL. Please, provide  valid direct url to RSS feeds
      static func urlError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("UrlError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "UrlError"
        }

        return NSLocalizedString("UrlError", bundle: bundle, comment: "")
      }

      /// Value: Link is corrupted or empry, unable to open link
      static func linkValidationMsg(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("LinkValidationMsg", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "LinkValidationMsg"
        }

        return NSLocalizedString("LinkValidationMsg", bundle: bundle, comment: "")
      }

      /// Value: Mark as read
      static func markAsRead(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("MarkAsRead", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "MarkAsRead"
        }

        return NSLocalizedString("MarkAsRead", bundle: bundle, comment: "")
      }

      /// Value: Mark as unread
      static func markAsUnread(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("MarkAsUnread", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "MarkAsUnread"
        }

        return NSLocalizedString("MarkAsUnread", bundle: bundle, comment: "")
      }

      /// Value: Network error. Please, try again
      static func networkError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("NetworkError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "NetworkError"
        }

        return NSLocalizedString("NetworkError", bundle: bundle, comment: "")
      }

      /// Value: No categories
      static func noCategoriesPlaceholcer(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("NoCategoriesPlaceholcer", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "NoCategoriesPlaceholcer"
        }

        return NSLocalizedString("NoCategoriesPlaceholcer", bundle: bundle, comment: "")
      }

      /// Value: No feeds found. Tap '+' to add new rss feed.
      static func noFeedsPlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("NoFeedsPlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "NoFeedsPlaceholder"
        }

        return NSLocalizedString("NoFeedsPlaceholder", bundle: bundle, comment: "")
      }

      /// Value: OK
      static func okLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("OkLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "OkLabel"
        }

        return NSLocalizedString("OkLabel", bundle: bundle, comment: "")
      }

      /// Value: Oops!
      static func folderNameValidationTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("FolderNameValidationTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "FolderNameValidationTitle"
        }

        return NSLocalizedString("FolderNameValidationTitle", bundle: bundle, comment: "")
      }

      /// Value: Reset
      static func resetLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ResetLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ResetLabel"
        }

        return NSLocalizedString("ResetLabel", bundle: bundle, comment: "")
      }

      /// Value: Unable to proceed
      static func linkValidationTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("LinkValidationTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "LinkValidationTitle"
        }

        return NSLocalizedString("LinkValidationTitle", bundle: bundle, comment: "")
      }

      /// Value: Unable to read RSS. Make sure valid URL provided
      static func parsingError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ParsingError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ParsingError"
        }

        return NSLocalizedString("ParsingError", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _NewsTableViewCell.validate()
      try _TableViewHeaderCell.validate()
    }

    struct _NewsTableViewCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "NewsTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "no-image", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'no-image' is used in nib 'NewsTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _TableViewHeaderCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "TableViewHeaderCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TableViewHeaderCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TableViewHeaderCell
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "arrow.down") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'arrow.down' is used in nib 'TableViewHeaderCell', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "folder.fill") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'folder.fill' is used in nib 'TableViewHeaderCell', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try addEditFeedViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try addEditFolderViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try feedsViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try newsDetailsViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try newsFilterViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try newsViewController.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct addEditFeedViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = AddEditFeedViewController

      let addEditFeedViewController = StoryboardViewControllerResource<AddEditFeedViewController>(identifier: "AddEditFeedViewController")
      let bundle = R.hostingBundle
      let name = "AddEditFeedViewController"

      func addEditFeedViewController(_: Void = ()) -> AddEditFeedViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: addEditFeedViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.addEditFeedViewController().addEditFeedViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'addEditFeedViewController' could not be loaded from storyboard 'AddEditFeedViewController' as 'AddEditFeedViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct addEditFolderViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = AddEditFolderViewController

      let addEditFolderViewController = StoryboardViewControllerResource<AddEditFolderViewController>(identifier: "AddEditFolderViewController")
      let bundle = R.hostingBundle
      let name = "AddEditFolderViewController"

      func addEditFolderViewController(_: Void = ()) -> AddEditFolderViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: addEditFolderViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.addEditFolderViewController().addEditFolderViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'addEditFolderViewController' could not be loaded from storyboard 'AddEditFolderViewController' as 'AddEditFolderViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct feedsViewController: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let feedsViewController = StoryboardViewControllerResource<FeedsViewController>(identifier: "FeedsViewController")
      let name = "FeedsViewController"

      func feedsViewController(_: Void = ()) -> FeedsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: feedsViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "rss-icon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'rss-icon' is used in storyboard 'FeedsViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.feedsViewController().feedsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'feedsViewController' could not be loaded from storyboard 'FeedsViewController' as 'FeedsViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct newsDetailsViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = NewsDetailsViewController

      let bundle = R.hostingBundle
      let name = "NewsDetailsViewController"
      let newsDetailsViewController = StoryboardViewControllerResource<NewsDetailsViewController>(identifier: "NewsDetailsViewController")

      func newsDetailsViewController(_: Void = ()) -> NewsDetailsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsDetailsViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.newsDetailsViewController().newsDetailsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsDetailsViewController' could not be loaded from storyboard 'NewsDetailsViewController' as 'NewsDetailsViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct newsFilterViewController: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "NewsFilterViewController"
      let newsFilterViewController = StoryboardViewControllerResource<NewsFilterViewController>(identifier: "NewsFilterViewController")

      func newsFilterViewController(_: Void = ()) -> NewsFilterViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsFilterViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.newsFilterViewController().newsFilterViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsFilterViewController' could not be loaded from storyboard 'NewsFilterViewController' as 'NewsFilterViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct newsViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = NewsViewController

      let bundle = R.hostingBundle
      let name = "NewsViewController"
      let newsViewController = StoryboardViewControllerResource<NewsViewController>(identifier: "NewsViewController")

      func newsViewController(_: Void = ()) -> NewsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.newsViewController().newsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsViewController' could not be loaded from storyboard 'NewsViewController' as 'NewsViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}

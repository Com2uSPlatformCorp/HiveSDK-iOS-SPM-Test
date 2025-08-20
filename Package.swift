// swift-tools-version: 5.10
import PackageDescription

private let packageVersion = "0.1.0"

let package = Package(
    name: "Hive",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "HiveSDK",
            type: .static,
            targets: [
                "HiveSDK"
            ]
        ),
        .library(
            name: "Hive_SDKPlugin",
            type: .static,
            targets: [
                "Plugin"
            ]
        ),
        .library(
            name: "Hive_SDKUnityPlugin",
            type: .static,
            targets: [
                "UnityPlugin"
            ]
        ),
        .library(
            name: "Hive_Promotion",
            type: .static,
            targets: [
                "Promotion"
            ]
        ),
        .library(
            name: "Hive_DeviceManagement",
            type: .static,
            targets: [
                "DeviceManagement"
            ]
        ),
        .library(
            name: "Hive_AuthV4ProviderGoogle",
            type: .static,
            targets: [
                "AuthV4ProviderGoogle"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", exact: "5.20.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", exact: "8.0.0")
    ],
    targets: [
// MARK: HiveSDK
        .target(
            name: "HiveSDK",
            dependencies: [
                .target(name: "HIVECore"),
                .target(name: "HIVECoreResource"),
                .target(name: "HIVEProtocol"),
                .target(name: "HIVEUI"),
                .target(name: "HIVEUIResource"),
                .target(name: "HIVEService"),
                .target(name: "HIVEServiceResource"),
                .product(name: "SDWebImage", package: "SDWebImage"),
            ],
            path: "SDK",
            sources: [
                "HiveSDK.swift"
            ]
        ),
        xcframeworkTarget(name: "HIVECore", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        xcframeworkTarget(name: "HIVEProtocol", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        xcframeworkTarget(name: "HIVEUI", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        xcframeworkTarget(name: "HIVEService", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        bundleTarget(isPrefixUppercased: true, name: "Core"),
        bundleTarget(isPrefixUppercased: true, name: "UI", as: ""),
        bundleTarget(isPrefixUppercased: true, name: "Service"),
// MARK: HIVE_SDK_Plugin
        .target(
            name: "Plugin",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVE_SDK_Plugin")
            ],
            path: "SDKPlugin",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-std=c++11", "-stdlib=libc++", "-fcxx-modules"])
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-ObjC"
                ])
            ]
        ),
        xcframeworkTarget(name: "HIVE_SDK_Plugin", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
// MARK: HIVE_SDK_UnityPlugin
        .target(
            name: "UnityPlugin",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HIVE_SDK_UnityPlugin")
            ],
            path: "SDKUnityPlugin",
            publicHeadersPath: ".",
            cxxSettings: [
                .unsafeFlags(["-std=c++11", "-stdlib=libc++", "-fcxx-modules"])
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-ObjC"
                ])
            ]
        ),
        xcframeworkTarget(name: "HIVE_SDK_UnityPlugin", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
// MARK: HivePromotion
        .target(
            name: "Promotion",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HivePromotion"),
                .target(name: "HivePromotionResource")
            ],
            path: "Promotion"
        ),
        xcframeworkTarget(name: "HivePromotion", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        bundleTarget(name: "Promotion"),
// MARK: HiveDeviceManagement
        .target(
            name: "DeviceManagement",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "HiveDeviceManagement"),
                .target(name: "HiveDeviceManagementResource")
            ],
            path: "DeviceManagement"
        ),
        xcframeworkTarget(name: "HiveDeviceManagement", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b"),
        bundleTarget(name: "DeviceManagement"),
// MARK: HiveAuthV4ProviderGoogle
        .target(
            name: "AuthV4ProviderGoogle",
            dependencies: [
                .target(name: "HiveSDK"),
                .target(name: "ProviderGoogle"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
            ],
            path: "AuthV4ProviderGoogle"
        ),
        xcframeworkTarget(name: "ProviderGoogle", checksum: "d03596efd545fde3df53fbbb2d102dc58c6163a8913a18b432905f5901c7763b")
    ]
)

private func xcframeworkTarget(
    name: String,
    checksum: String
) -> Target {
    .binaryTarget(
        name: name,
        url: "https://github.com/Com2uSPlatformCorp/HiveSDK-iOS-SPM-Test/releases/download/\(packageVersion)/XcFrameworks.zip",
        checksum: checksum
    )
}

private func bundleTarget(
    isPrefixUppercased: Bool = false,
    name: String,
    as customName: String? = nil
) -> Target {
    let hiveString = isPrefixUppercased ? "HIVE" : "Hive"
    let bundleName = "\(name)Resource"
    let targetName = "\(hiveString)\(name)Resource"
    let bundlePath = "\(hiveString)\(customName ?? name)Resource.bundle"
    let sourcePath = "Hive_\(bundleName).swift"
    let infoPlists = name != "Service"
    ? ["\(bundlePath)/Info.plist"]
    : ["\(bundlePath)/Info.plist",
       "\(bundlePath)/HIVEResource.storyboardc/Info.plist"]
    
    return .target(
        name: targetName,
        path: bundleName,
        exclude: infoPlists,
        sources: [
            sourcePath
        ],
        resources: [
            .process(bundlePath)
        ],
        publicHeadersPath: ""
    )
}

// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "SIDSDK",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "SIDSDKDynamic",
			targets: ["SIDSDKDynamicWrapper"]
		),
		.library(
			name: "SIDSDKStatic",
			targets: ["SIDSDKStaticWrapper"]
		)
	],
	dependencies: [
		.package(
			url: "https://gitverse.ru/clickstream/iOS-SDK-Package.git",
			exact: "1.6.0"
		)
	],
	targets: [
		// Бинарная цель для динамической библиотеки
		.target(
			name: "SIDSDKDynamicWrapper",
			dependencies: [
				.target(name: "SIDSDKDynamicBinary"),
				.product(name: "Clickstream", package: "iOS-SDK-Package")
			]
		),
		.binaryTarget(
			name: "SIDSDKDynamicBinary",
			path: "XCFrameworks/SIDSDKDynamic.zip"
		),

		// Обёртка над статической библиотекой, куда «прокидываем» bundle
		.target(
			name: "SIDSDKStaticWrapper",
			dependencies: [
				.target(name: "SIDSDKStaticBinary"),
				.product(name: "Clickstream", package: "iOS-SDK-Package")
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Бинарная цель для статической библиотеки
		.binaryTarget(
			name: "SIDSDKStaticBinary",
			path: "./XCFrameworks/SIDSDKStatic.zip"
		)
	]
)

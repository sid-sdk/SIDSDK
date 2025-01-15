// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "SIDSDK",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v14)
	],
	products: [
		.library(
			name: "SIDSDKStatic",
			targets: ["SIDSDKStaticWrapper"]
		),
		.library(
			name: "SIDSDKDynamic",
			targets: ["SIDSDKDynamic"]
		),
	],
	targets: [
		// Бинарная цель для статической библиотеки
		.binaryTarget(
			name: "SIDSDKStaticBinary",
			path: "./XCFrameworks/SIDSDKStatic.zip"
		),
		// Бинарная цель для динамической библиотеки
		.binaryTarget(
			name: "SIDSDKDynamic",
			path: "XCFrameworks/SIDSDKDynamic.zip"
		),
		// Обёртка над статической библиотекой, куда «прокидываем» bundle
		.target(
			name: "SIDSDKStaticWrapper",
			dependencies: [
				.target(name: "SIDSDKStaticBinary")
			],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
	]
)

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
		.library(
			name: "SIDSDKDynamic-CS",
			targets: ["SIDSDKDynamic-CS"]
		),
		.library(
			name: "SIDSDKStatic-CS",
			targets: ["SIDSDKStaticWrapper-CS"]
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
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Бинарная цель для статической библиотеки без Кликстрима
		.binaryTarget(
			name: "SIDSDKStaticBinary-CS",
			path: "./XCFrameworks/SIDSDKStatic-CS.zip"
		),
		// Бинарная цель для динамической библиотеки без Кликстрима
		.binaryTarget(
			name: "SIDSDKDynamic-CS",
			path: "XCFrameworks/SIDSDKDynamic-CS.zip"
		),
		// Обёртка над статической библиотекой, куда «прокидываем» bundle. Без Кликстрима
		.target(
			name: "SIDSDKStaticWrapper-CS",
			dependencies: [
				.target(name: "SIDSDKStaticBinary-CS")
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
	]
)

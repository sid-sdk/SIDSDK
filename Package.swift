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
			targets: ["SIDSDKDynamicWrapper"]
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
	dependencies: [
		// Добавляем зависимость на Clickstream
		.package(url: "https://github.com/clickstream-developers/Clickstream-iOS", from: "1.5.0")
	],
	targets: [
		// Бинарная цель для статической библиотеки
		.binaryTarget(
			name: "SIDSDKStaticBinary",
			path: "./XCFrameworks/SIDSDKStatic.zip"
		),
		// Бинарная цель для динамической библиотеки
		.binaryTarget(
			name: "SIDSDKDynamicBinary",
			path: "XCFrameworks/SIDSDKDynamic.zip"
		),
		// Обёртка над статической библиотекой, куда «прокидываем» bundle
		.target(
			name: "SIDSDKStaticWrapper",
			dependencies: [
				.target(name: "SIDSDKStaticBinary"),
				.product(name: "Clickstream", package: "Clickstream-iOS") // Добавляем Clickstream как зависимость
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Обёртка над динамической библиотекой, куда добавляем Clickstream
		.target(
			name: "SIDSDKDynamicWrapper",
			dependencies: [
				.target(name: "SIDSDKDynamicBinary"),
				.product(name: "Clickstream", package: "Clickstream-iOS") // Добавляем Clickstream как зависимость
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

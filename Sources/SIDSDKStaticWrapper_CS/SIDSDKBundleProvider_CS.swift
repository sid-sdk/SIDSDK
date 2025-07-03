//
//  SIDSDKBundleProvider_CS.swift
//  SIDSDK
//
//  Created by Валиева Анна Евгеньевна on 16.01.2025.
//

import Foundation


public class SIDSDKBundleProvider_CS: NSObject {
	@objc public static var sdkBundle: Bundle {
		return Bundle.module
	}
}

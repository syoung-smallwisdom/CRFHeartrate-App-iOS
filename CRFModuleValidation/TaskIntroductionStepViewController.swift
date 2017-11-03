//
//  TaskIntroductionStepViewController.swift
//  CRFModuleValidation
//
//  Copyright © 2017 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import UIKit
import ResearchSuiteUI
import ResearchSuite
import ResearchUXFactory

class TaskIntroductionStepViewController: RSDStepViewController {
    
    override func shouldUseGlobalButtonVisibility() -> Bool {
        return false
    }
    
    override func showLearnMore() {
        guard let action = self.action(for: .navigation(.learnMore)) as? RSDResourceTransformer
            else {
            self.presentAlertWithOk(title: nil, message: "Missing learn more action for this task", actionHandler: nil)
            return
        }
        
        do {
            // TODO: syoung 11/01/2017 Replace BridgeAppSDK implementation of a webview with one that can load html from an embedded resource.
            let (data, _) = try action.resourceData()
            let html = String(data: data, encoding: String.Encoding.utf8)
            let webVC = SBAWebViewController()
            webVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(_dismissChildViewController))
            webVC.html = html
            let navVC = UINavigationController(rootViewController: webVC)
            self.present(navVC, animated: true, completion: nil)
            
        } catch let err {
            self.presentAlertWithOk(title: nil, message: "Cannot load learn more for this task. \(err)", actionHandler: nil)
        }
    }
    
    @objc func _dismissChildViewController() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }

    override func skipForward() {
        // TODO: Implement remind me later
        self.presentAlertWithOk(title: nil, message: "Not yet implemented", actionHandler: nil)
    }
}
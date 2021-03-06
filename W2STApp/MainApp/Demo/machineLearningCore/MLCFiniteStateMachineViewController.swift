/*
* Copyright (c) 2019  STMicroelectronics – All rights reserved
* The STMicroelectronics corporate logo is a trademark of STMicroelectronics
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
* - Redistributions of source code must retain the above copyright notice, this list of conditions
*   and the following disclaimer.
*
* - Redistributions in binary form must reproduce the above copyright notice, this list of
*   conditions and the following disclaimer in the documentation and/or other materials provided
*   with the distribution.
*
* - Neither the name nor trademarks of STMicroelectronics International N.V. nor any other
*   STMicroelectronics company nor the names of its contributors may be used to endorse or
*   promote products derived from this software without specific prior written permission.
*
* - All of the icons, pictures, logos and other images that are provided with the source code
*   in a directory whose title begins with st_images may only be used for internal purposes and
*   shall not be redistributed to any third party or modified in any way.
*
* - Any redistributions in binary form shall not include the capability to display any of the
*   icons, pictures, logos and other images that are provided with the source code in a directory
*   whose title begins with st_images.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
* AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
* OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
* OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
* OF SUCH DAMAGE.
*/


import Foundation

class MLCFiniteStateMachineViewController : BlueMSDemoTabViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MLCMachineLearningViewModel(featureType: BlueSTSDKFeatureFiniteStateMachine.self,mapperCommand: "getFSMLabels\n")
    private let dataAdapter = RegisterStatusDataSourceAdapter(registerWithNameFormat: MLCFiniteStateMachineViewController.REGISTER_ID_NAME_FORMAT,
                                                              registerWithoutNameFormat: MLCFiniteStateMachineViewController.REGISTER_ID_FORMAT)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterStatusDataSourceAdapter.registerCellFor(tableView: tableView)
        tableView.dataSource = dataAdapter
        viewModel.onNewStatusAvailable = { [weak self] newStatus in
            self?.dataAdapter.data = newStatus
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startListeDataFrom(node: self.node)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopListenDataFrom(node: self.node)
    }
    static let REGISTER_ID_FORMAT = {
        return  NSLocalizedString("Program %d",
                                  tableName: nil,
                                  bundle: Bundle(for: MLCFiniteStateMachineViewController.self),
                                  value: "Program %d",
                                  comment: "Program %d")
    }();
    
    static let REGISTER_ID_NAME_FORMAT = {
        return  NSLocalizedString("Program %d - %@",
                                  tableName: nil,
                                  bundle: Bundle(for: MLCFiniteStateMachineViewController.self),
                                  value: "Program %d - %@",
                                  comment: "Program %d - %@")
    }();
}

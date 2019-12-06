//
//  ViewController.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import UIKit
import RxSwift
 
/*
- `ViewBindable`:
`UIViewController`에 bind 할 수 있는 명세를 나타내며, **protocol**로 작성되어야만 합니다.
*/
class ViewController<ViewBindable>: UIViewController {
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initialize()
    }
    deinit {
        print("\(ViewBindable.self) 메모리 할당 해제")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    /*
     `UIViewController`의 다양한 레이아웃 속성을 정의합니다.
     
     - `ViewBindable`과 각 컴포넌트들의 속성을 binding
     - `bind`에서는 가변적인 속성의 정의 동작과 위치의 변화를 모두 수행할 수 있다
     
     *(단 직접적으로 입력하는 동작이 아닌 어떠한 Observable에 따라 변화되는 동작만을 정의)*
     
     - Parameters:
     - viewModel: view에 bind 할 수 있는 `ViewBindable` 명세를 나타내며, **protocol**로 작성되어야만 합니다.
     */
    func bind(_ viewModel: ViewBindable) {}
    
    /*
     `UIViewController`의 다양한 레이아웃 속성을 정의합니다.
     
     - 기존의 `layout`과 같은 역할
     - 컴포넌트들의 위치를 정의하고 부모View에 Add하는 동작을 수행
     */
    func layout() {}
    
    /*
     `UIViewController`의 다양한 프로퍼티의 속성을 정의합니다.
     
     - 컴포넌트들의 속성을 정의하는 동작을 수행
     - `Then`의 `do`라는 함수를 통해 각 컴포넌트들의 속성을 그룹핑
     */
    func attribute() {}
    
    /*
     `init()` 시점에 주입되어야 할 Cocoa 종속성 properties에 대한 변경이 필요할 때 사용합니다.
     ⚠️ 주의: init 시점이 아닌 properties를 변경할 경우 viewDidLoad() 시점에 영향을 줄 수 있음
     */
    func initialize() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


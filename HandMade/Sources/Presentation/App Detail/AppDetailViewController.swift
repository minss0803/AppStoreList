//
//  AppDetailViewController.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

enum AppDetailInfoType: CaseIterable {
    case size   // 앱 크기
    case age    // 앱 사용연령대
    case releaseNote // 새로운 기능
}
protocol AppDetailViewBindable {
    
    //View -> ViewModel
    var detailData: PublishSubject<AppInfo> { get }
    
    //ViewModel -> View
    var appInfoData: Driver<AppInfo> { get }
    var appDetailInfoData: Driver<[AppDetailInfoView.Data]> { get }
    var screenShotData: Driver<[String]> { get }
    var reloadList: Signal<Void> { get }
}

class AppDetailViewController: ViewController<AppDetailViewBindable> {

    private struct UI {
        static let collectionViewWidth = UIScreen.main.bounds.width
        static let collectionViewHeight = (collectionViewWidth / 2.0) * 1.78
        static let itemSize = CGSize(width: collectionViewWidth/2.0, height: collectionViewHeight)
        static let descriptionHeight = 300
        static let divisionHeight = 20
        static let divisionBgColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
    }
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()   // scrollView의 contentView 역할 (stack 구조)
    let appTitleView = AppTitleView() // 앱 정보
    let appDetailInfoViews = [AppDetailInfoView(), AppDetailInfoView(), AppDetailInfoView()]
    let descriptionLabel = PeddingLabel()
    let divisionView1 = UIView()
    let genreView = AppGenreView()
    let divisionView2 = UIView()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) // 앱 스크린샷 정보
    var trackViewUrl: URL?

    override func bind(_ viewModel: AppDetailViewBindable) {
        self.disposeBag = DisposeBag()
        
        // 앱 정보를 업데이트 합니다.
        viewModel.appInfoData
            .drive(onNext: { [weak self] data in
                self?.appTitleView.setData(data: data)
                self?.genreView.setData(data: data)
                self?.descriptionLabel.text = data.description
            })
            .disposed(by: disposeBag)
        
        // 앱 스크린샷 정보를 업데이트 합니다.
        viewModel.screenShotData
            .drive(collectionView.rx.items) { cv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: ScreenShotCell.self), for: index) as! ScreenShotCell
                cell.setData(data: data)
                return cell
            }
            .disposed(by: disposeBag)
        
        // 앱 상세정보를 업데이트 합니다.
        viewModel.appDetailInfoData
            .drive(onNext: { [weak self] dataArray in
                guard let views = self?.appDetailInfoViews else { return }

                for (view, data) in zip(views, dataArray) {
                    view.setData(data: data)
                }
            })
            .disposed(by: disposeBag)
        
        // 새로운 앱 정보가 들어왔을 때, 스크린샷 업데이트 합니다.
        viewModel.reloadList
            .emit(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // 딥링크 정보를 업데이트 합니다.
        viewModel.detailData
            .subscribe(onNext: { [weak self] data in
                guard let url = URL(string: data.trackViewUrl ?? "") else {
                    return
                }
                self?.trackViewUrl = url
            })
            .disposed(by: disposeBag)
        
        // 아코디언 메뉴의 Tap Gesture를 선언합니다.
        appDetailInfoViews.forEach { (view) in
            view.rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    view.animExpand()
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    }
                })
                .disposed(by: disposeBag)
        }
        /// 웹으로 가기
        appTitleView.openWebButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                guard let url = self?.trackViewUrl else {
                    return
                }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            })
            .disposed(by: disposeBag)
        
        // 공유하기 창 띄우기
        appTitleView.shareButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                guard let url = self?.trackViewUrl else {
                    return
                }
                let activity = UIActivityViewController(
                    activityItems: [url],
                    applicationActivities: nil)
                self?.present(activity, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        view.do {
            $0.backgroundColor = .white
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 0
        }
        
        collectionView.do {
            $0.register(ScreenShotCell.self, forCellWithReuseIdentifier: String(describing: ScreenShotCell.self))
            $0.backgroundColor = .white
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = false
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = UI.itemSize
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.collectionViewLayout = flowLayout
        }
        descriptionLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        }
        divisionView1.do {
            $0.backgroundColor = UI.divisionBgColor
        }
        divisionView2.do {
            $0.backgroundColor = UI.divisionBgColor
        }
    }
    
    override func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(appTitleView)
        for view in appDetailInfoViews {
            stackView.addArrangedSubview(view)
        }
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(divisionView1)
        stackView.addArrangedSubview(genreView)
        stackView.addArrangedSubview(divisionView2)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.bottom.left.right.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(0).priority(250)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(UI.collectionViewHeight)
        }
        descriptionLabel.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(UI.descriptionHeight)
        }
        divisionView1.snp.makeConstraints {
            $0.height.equalTo(UI.divisionHeight)
        }
    }
}

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let words: [String] = ["Popular", "Featured", "Most Visited", "Europe", "Asian"]
    var collectionView: UICollectionView!
    var selectedWordIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupHeaderView() {
        let headerLabel = UILabel()
        headerLabel.text = "Discover"
        headerLabel.font = UIFont(name: "SFProDisplay-Black", size: 32)
        view.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WordCell.self, forCellWithReuseIdentifier: "WordCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as! WordCell
        cell.label.text = words[indexPath.item]
        
        //  является ли ячейка выбранной
        cell.isSelectedWord = indexPath.item == selectedWordIndex
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = words[indexPath.item].size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]).width + 20
        return CGSize(width: width, height: 50)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWordIndex = indexPath.item
        collectionView.reloadData()
    }
}

class WordCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 106/255, green: 98/255, blue: 184/255, alpha: 1)
        view.layer.cornerRadius = 6
        view.isHidden = true
        return view
    }()
    
    var isSelectedWord: Bool = false {
        didSet {
            indicatorView.isHidden = !isSelectedWord
            label.textColor = isSelectedWord ? UIColor(red: 106/255, green: 98/255, blue: 184/255, alpha: 1) : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview()
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(label.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(1)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(9)
        }
    }
}

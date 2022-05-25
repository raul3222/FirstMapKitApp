//
//  DetailedCardViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 16.05.2022.
//

import UIKit

class DetailedCardViewController: UIViewController {

    @IBOutlet  var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardTitleLabel: UILabel!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var trailingContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var shouldMove = false
    var sight: Sight!
    
    var imgArray = [
        UIImage(named: "cathedral-1"),
        UIImage(named: "cathedral-2"),
        UIImage(named: "cathedral-3")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        configureSideMenu()
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
        configureView()
        pageControl.currentPage = 0
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.numberOfPages = imgArray.count
        descriptionLabel.text = """
Единственный в России Музей янтаря был открыт в 1979 году. Он расположен в центре Калининграда на берегу озера Верхнее в крепостной башне середины ХIХ века.

Башня была построена в 1853 году под руководством разработчика общего плана крепостных сооружений Кёнигсберга шефа инженерного корпуса Эрнста Людвига фон Астера и входила в систему городских оборонительных укреплений. Она носила имя прусского генерал-фельдмаршала Фридриха Карла Дона, участника освободительной войны против наполеоновского нашествия. Здание является также памятником Второй мировой войны.

Музей янтаря – это музей одного минерала. Экспозиция расположена на трех этажах здания общей площадью около 1000 кв. метров. По содержанию она делится на естественно-научную и культурно-историческую части.

Янтарь – это окаменевшая смола древних хвойных деревьев, произраставших более 40 млн. лет назад на современной территории Скандинавского полуострова и прилегающих к нему областях дна Балтийского моря.

В естественно-научном разделе собрания представлены различные по весу, цветовой гамме, степени прозрачности образцы янтаря. В экспозиции находится самый крупный в России «солнечный камень»: его вес – 4 кг 280 г. Значительную часть коллекции составляют образцы янтаря с включениями остатков животных и растительных организмов, попавших десятки миллионов лет назад в некогда жидкую и вязкую смолу. Включения в балтийском янтаре представляют большой научный интерес благодаря своему разнообразию и превосходной сохранности. Они ценны для уточнения наших знаний о флоре и фауне, а также климатических условиях на Земле 40 – 45 млн. лет назад. На сегодняшний день коллекция Калининградского музея янтаря является главным российским национальным фондом инклюзов в балтийском янтаре.
"""
        
    }
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            shouldMove = true
            showMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        } else {
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        }
    }
    
    @IBAction func showOnTheMapBtnPressed(_ sender: Any) {
        
    }
    
    private func configureView() {
//        cardTitleLabel.text = sight.title
        guard let image = sight.imageSrc else { return }
        //fetchImage(with: image)
    }
    
//    private func fetchImage(with name: String) {
//
//        let url = URL(string: name)
//        imageView.kf.setImage(with: url)
//    }

}

extension DetailedCardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerItem", for: indexPath) as! BannerCollectionViewCell
        cell.configureCell(with: imgArray[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 10
        let height = collectionView.layer.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

//
//  ViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 11.05.2022.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var initialLocation = CLLocation(latitude: 54.7064900, longitude: 20.5109500)
    var sights = [SightModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCoreLocation()
        setZoomRange()
        createPins()
        mapView.delegate = self
        mapView.register(SightView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)//используем пока дефолтный идентификатор, потому что у нас класс с одним типом аннотаций.
//        sights = ApiManager.shared.getSights()
//        print("Test \(sights.count)")
        
        
        
    }
    @IBAction func currentLocationPressed(_ sender: Any) {
        mapView.centerToLocation(location: initialLocation)
    }
}
//MARK: Определяем текущие координаты
extension ViewController: CLLocationManagerDelegate {
    //MARK: Следующие 2 метода обязательные
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        initialLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.centerToLocation(location: initialLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func configureCoreLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
    }
    
    private func setZoomRange() {
        let kaliningradCenter = CLLocation(latitude: 54.7064900, longitude: 20.5109500)
        let region = MKCoordinateRegion(
            center: kaliningradCenter.coordinate,
            latitudinalMeters: 100000,
            longitudinalMeters: 250000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 300000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    //MARK: Добавляем 1 пробный пин вручную
    private func createPins() {
        let cathedral = Sights(
            title: "Cathedral",
            locationName: "Immanuel Kant Island",
            type: "church",
            coordinate: CLLocationCoordinate2D(latitude: 54.706443, longitude: 20.511817))
        mapView.addAnnotation(cathedral)
    }
}


private extension MKMapView {
    //MARK: центруем карту на основании координат переданных в метод. regionRadius - что то вроде масштаба
  func centerToLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

//MARK: Настраиваем внешний вид пина, чтобы при нажатии открывалось окошко
extension ViewController: MKMapViewDelegate {
    //Обрабатываем нажатие кнопки i во всплывающем окне
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let sight = view.annotation as? Sights else { return }
        
        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ]
        sight.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
    // метод ниже обращается ко всем аннотация добавленным на карту. Похоже на cellForRowAt в tableView. Закоменчен, т.к. логика перенесена в класс SightViews???
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // Проверяем, что наш пин именно принадлежит классу Sight. Так как в приложении могут быть другие типы пинов.
//        guard let annotation = annotation as? Sights else { return nil }
//
//        let identifier = "sight"
//        //Каждую view создаем как MKMarkerAnnotationView т.к. работаем с маркерами. Когда будем работать с иконками, будем создавать MKAnnotationView
//        var view: MKMarkerAnnotationView
//        //Проверка ниже не совсем понятна
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            view = MKMarkerAnnotationView(
//            annotation: annotation,
//            reuseIdentifier: identifier)
//            view.canShowCallout = true // если false, окошко не открывается
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            //метод left/rightCalloutAccessoryview отвечает за расположение кнопки i в окошке. Слева или справа от текста
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
}



//
//  ViewController.swift
//  collagemaker
//
//  Created by Natasha Radika on 29/12/25.
//

import UIKit
import RxSwift
import RxRelay

// this is root vc and isn't released when the app quits
class ViewController: UIViewController {

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!
    
    // as soon as VC is released, all the observable subscription will be disposed as well
    private let disposeBag = DisposeBag()
    
    // remember: Behavior Relay itu ngewrap behavior subject, tapi gabisa add completed atau error events
    // kalo behavior subject itu read + add value. mulai dengan initial value lalu kirim value terakhir / initial value ke latest subscriber
    // in other word: behavior relay selalu punya value dan non terminating
    // kenapa behavior relay instead of publish subject? karena ketika new page/screen muncul trs mau subscribe, subscriber baru ttp dapet latest value
    private let images = BehaviorRelay<[UIImage]>(value: [])

    override func viewDidLoad() {
      super.viewDidLoad()

    }
    
    @IBAction func actionClear() {
        images.accept([])
    }

    @IBAction func actionSave() {

    }

    @IBAction func actionAdd() {
        // ketika user click +
        // dapetin data dari assets
        // basically images ini kayak array doang yang nyimpen value2 tapi bedanya dia bisa async aja wkkwk
        let newImages = images.value + [UIImage(named: "IMG_1907.jpg")!]
        // masukin data ke stream
        images.accept(newImages)
    }

    func showMessage(_ title: String, description: String? = nil) {
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
      present(alert, animated: true, completion: nil)
    }
}


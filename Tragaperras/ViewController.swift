//
//  ViewController.swift
//  Tragaperras
//
//  Copyright © Pacopul. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var iv1: UIImageView!
    @IBOutlet weak var iv2: UIImageView!
    @IBOutlet weak var iv3: UIImageView!
    
    var ivdados:[UIImageView]!
    var figuras:[String] = ["campana", "cereza", "dolar", "fresa", "limon", "siete"]
    
    var player : AVAudioPlayer!
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivdados = [iv1, iv2, iv3]
        loadAnimation()
        loadSound()
    }
    
    
    @IBAction func onPlayStart(_ sender: UIButton) {
        for iv in ivdados {
            iv.startAnimating()
        }
        if let player = player{
            player.play()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
            var tts=""
            for iv in self.ivdados {
                iv.stopAnimating()
            }
            for iv in self.ivdados {
                tts += self.inventaypinta(iv)
            }
            if let player = self.player{
                player.stop()
            }
            self.speak(tts)
        })
    }
    
    func speak(_ tts:String) {
        let utterance = AVSpeechUtterance(string: tts)
        utterance.voice =  AVSpeechSynthesisVoice(language: "pt-BR")
        synth.speak(utterance)
    }
    
    func loadAnimation() {
        for ivdado in ivdados {
            ivdado.animationImages = [UIImage]()
            for figura in figuras.shuffled() {
                let frameName = figura
                ivdado.animationImages?.append(UIImage(named: frameName)!)
            }
            ivdado.animationDuration = 0.6
        }
    }
    
    func loadSound() {
        do {
            // desenvolviendo una variable (unwrapping var)
            if let fileURL = Bundle.main.path(forResource: "tragaperras", ofType:"mp3") {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No existe fichero de sonido")
            }
        } catch let error {
            print("Error en la carga del sonido \(error.localizedDescription)")
        }
        
    }
    
    func inventaypinta(_ iv:UIImageView) -> String {
        let n = Int(arc4random() % 6);
        let image = UIImage(named: figuras[n])
        iv.image=image
        return figuras[n]+" "
    }
    
}


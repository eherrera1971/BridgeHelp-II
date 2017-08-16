//
//  ViewController.swift
//  BridgeHelp II
//
//  Created by Eduardo Herrera on 8/12/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit

class cartaBridge : UIButton {
    var suit : String
    var rank : String
    var estado : String
    
    required init(palo : String, valor : String, estado : String , cuadro : CGRect) {
        self.suit = palo
        self.rank = valor
        self.estado = estado
        super.init(frame: cuadro)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error Fatal")
    }
}

class ViewController: UIViewController {

    var cartasSur = 13
    
    var cartas = [cartaBridge]()
    
 
    @IBOutlet weak var mensaje: UILabel!
    
    @IBOutlet weak var datosSur: UILabel!
    
    @IBOutlet weak var labelS: UILabel!
    var cantidadS = 0
    @IBOutlet weak var labelH: UILabel!
    var cantidadH = 0
    @IBOutlet weak var labelD: UILabel!
    var cantidadD = 0
    @IBOutlet weak var labelC: UILabel!
    var cantidadC = 0
    
    @IBAction func touchCard(_ sender: cartaBridge) {
        if sender.estado == "Presente" {
        cartasSur = cartasSur - 1
        sender.setImage(#imageLiteral(resourceName: "FondoBrisasApps"), for: .normal)
        sender.estado = "Tocada"
        } else {
            cartasSur = cartasSur + 1
            sender.setImage(nil, for: .normal)
            sender.estado = "Presente"
        }
        mensaje.text = String(cartasSur)
        //Evaluar Puntos mios
    }
    
    @IBAction func nextStep(_ sender: UIButton) {
        for carta in cartas {
            if carta.estado == "Tocada" {
                carta.removeFromSuperview()
                carta.estado = "Sur"
            }
        }
        mensaje.text = "Datos del Bid"
        evaluarCartas(jugador: "Sur")
        //Agrupar cartas
        //Señales del Bid
    }
    

    func evaluarCartas(jugador: String) {
        var puntosHCP = 0
        for carta in cartas {
            if carta.estado == jugador {
                switch carta.rank {
                case "A" : puntosHCP += 4
                case "K" : puntosHCP += 3
                case "Q" : puntosHCP += 2
                case "J" : puntosHCP += 1
                default : puntosHCP += 0
                }
                switch carta.suit {
                case "♠️" : cantidadS += 1
                case "♥️" : cantidadH += 1
                case "♦️" : cantidadD += 1
                case "♣️" : cantidadC += 1
                default : break
                }
            }
        }
        datosSur.text = "PuntosHCP Sur : \(puntosHCP)"
        labelS.text = "♠️ \(cantidadS)"
        labelH.text = "♥️ \(cantidadH)"
        labelD.text = "♦️ \(cantidadD)"
        labelC.text = "♣️ \(cantidadC)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let suits = ["♠️","♥️","♦️","♣️"]
        let ranks = ["A","K","Q","J","10","9","8","7","6","5","4","3","2"]
        var vertical = 0
        var horizontal = 0
        var secuencia = 1
        for suit in suits {
        
        for rank in ranks {
            let button = cartaBridge(palo: suit,valor: rank,estado: "Presente",cuadro: CGRect(x: (220 + horizontal), y: (300 + vertical), width: 48, height: 64))
            button.backgroundColor = .white
            button.setTitle("\(rank)\(suit)", for: .normal)
            button.layer.cornerRadius = 5
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
            button.tag = secuencia
            cartas.append(button)
            self.view.addSubview(button)
            horizontal = horizontal + 52
            secuencia = secuencia + 1
        }
            vertical = vertical + 68
            horizontal = 0
        }
        mensaje!.text = String(cartasSur)
        // Do any additional setup after loading the view, typically from a nib.
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

*/
    
}


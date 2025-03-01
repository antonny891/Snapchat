//
//  ImagenViewController.swift
//  MamanchuraAlccaSnapchat
//
//  Created by Antonny Mmamanchura Alcca on 23/10/24.
//

import UIKit
import FirebaseStorage

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present (imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        self.elegirContactoBoton.isEnabled = false
            let imagenesFolder = Storage.storage().reference().child("imagenes")
            let imagenData = imageView.image?.jpegData (compressionQuality: 0.50)
            let cargarImagen = imagenesFolder.child("\(NSUUID().uuidString).jpg").putData (imagenData!, metadata:
                nil) { (metadata, error) in
                if error != nil {
                    self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al subir la imagen. Verifique su conexion a internet y vuelva a intentarlo.", accion: "Aceptar")
                    self.elegirContactoBoton.isEnabled = true
                    print("Ocurrio un error al subir imagen: \(error) ")
                }else{
                    self.performSegue (withIdentifier: "seleccionarContactoSegue",
                        sender: nil )
                }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, accion: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje,
            preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default,
            handler: nil)
        alerta.addAction (btnCANCELOK)
        present(alerta, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        imagenesFolder.child("imagenes.jpg").putData (imagenData!, metadata:
            nil) { (metadata, error) in
            if error != nil {
                print("Ocurrio un error al subir imagen: \(error) ")
            }
        }
    }
    
}

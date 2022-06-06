//
//  ViewController.swift
//  CircleMovementGame
//
//  Created by Admin on 06.06.2022.
//

import UIKit

enum Direction: String {
    case top = "top"
    case bottom = "bottom"
    case left = "left"
    case right = "right"
}

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var controlsView: UIView!
    @IBOutlet weak var resultLabel: UILabel!

    //MARK: - var/let
    private let circleView = UIView()
    private let circleSize: CGFloat = 80
    private let animationDuration = 0.2
    private let movementStep: CGFloat = 60
    private let screenSize = UIScreen.main.bounds
    private var safeScreenSides = UIEdgeInsets()
    private var canCircleMove = true

    //MARK: - lifecycle funcs
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        self.createView()

        self.safeScreenSides = self.view.safeAreaInsets

        self.controlsView.layer.cornerRadius = 20

        self.resultLabel.text = ""

    }

    //MARK: - IBActions
    @IBAction func moveLeftButtonPressed(_ sender: UIButton) {

        UIView.animate(withDuration: self.animationDuration) {

            self.move(direction: .left)

        }

    }

    @IBAction func moveRightButtonPressed(_ sender: UIButton) {

        UIView.animate(withDuration: self.animationDuration) {

            self.move(direction: .right)

        }

    }

    @IBAction func moveToTopButtonPressed(_ sender: UIButton) {

        UIView.animate(withDuration: self.animationDuration) {

            self.move(direction: .top)

        }

    }


    @IBAction func moveDownButtonPressed(_ sender: UIButton) {

        UIView.animate(withDuration: self.animationDuration) {

            self.move(direction: .bottom)

        }

    }

    //MARK: - flow func
    private func createView() {

        self.circleView.frame = CGRect(x: 100, y: 100, width: self.circleSize, height: self.circleSize)

        self.circleView.layer.cornerRadius = self.circleSize / 2

        self.circleView.backgroundColor = .orange

        self.view.addSubview(self.circleView)

    }

    private func move(direction: Direction) {

        self.canCircleMove = true

        switch direction {

        case .top:

            self.moveToTop()

        case .bottom:

            self.moveToBottom()

        case .left:

            self.moveToLeft()

        case .right:

            self.moveToRight()

        }

        self.printDirection(direction: direction, label: self.resultLabel)

    }

    private func printDirection(direction: Direction, label: UILabel) {

        if self.canCircleMove {

            label.text = "Movement \nto \(direction.rawValue)"

        } else {

            label.text = "Movement \nis not possible"

        }

    }

    private func moveToTop() {

        if (self.circleView.frame.origin.y > self.safeScreenSides.top + self.movementStep) {

            self.circleView.frame.origin.y -= self.movementStep

            if circleView.intersects(controlsView) {

                self.circleView.frame.origin.y = self.controlsView.frame.maxY

                self.canCircleMove = !self.canCircleMove
            }

        } else {

            self.circleView.frame.origin.y = self.safeScreenSides.top

            self.canCircleMove = !self.canCircleMove
        }

    }

    private func moveToBottom() {

        if (self.circleView.frame.origin.y < self.screenSize.maxY - self.safeScreenSides.bottom - self.circleSize) {

            self.circleView.frame.origin.y += self.movementStep

            self.moveToBottomSide()

            if circleView.intersects(controlsView) {

                self.circleView.frame.origin.y = self.controlsView.frame.minY - self.circleSize

                self.canCircleMove = false
            }

        } else {

            self.moveToBottomSide()

            self.canCircleMove = false

        }

    }

    private func moveToLeft() {

        if (self.circleView.frame.origin.x > self.safeScreenSides.left + self.movementStep) {

            self.circleView.frame.origin.x -= self.movementStep

            if circleView.intersects(controlsView) {

                self.circleView.frame.origin.x = self.controlsView.frame.maxX

                self.canCircleMove = !self.canCircleMove

            }

        } else {

            self.circleView.frame.origin.x = self.safeScreenSides.left

            self.canCircleMove = !self.canCircleMove

        }

    }

    private func moveToRight() {

        if (self.circleView.frame.origin.x < self.screenSize.maxX - self.safeScreenSides.right - self.circleSize) {

            self.circleView.frame.origin.x += self.movementStep

            self.moveToRightSide()

            if circleView.intersects(controlsView) {

                self.circleView.frame.origin.x = self.controlsView.frame.minX - self.circleSize

                self.canCircleMove = !self.canCircleMove

            }

        } else {

            self.moveToRightSide()

        }

    }

    private func moveToRightSide() {

        if self.circleView.frame.origin.x > self.screenSize.maxX - self.safeScreenSides.right - self.circleSize {

            self.circleView.frame.origin.x = self.screenSize.maxX - self.safeScreenSides.right - self.circleSize

            self.canCircleMove = !self.canCircleMove

        }

    }

    private func moveToBottomSide() {

        if (self.circleView.frame.origin.y > self.screenSize.maxY - self.safeScreenSides.bottom - self.circleSize) {

            self.circleView.frame.origin.y = self.screenSize.maxY - self.safeScreenSides.bottom - self.circleSize

        }

    }

}

//MARK: - extentions
extension UIView {

    func intersects(_ her: UIView) -> Bool {

        let herInMyGeometry = convert(her.bounds, from: her)

        return bounds.intersects(herInMyGeometry)

    }

}

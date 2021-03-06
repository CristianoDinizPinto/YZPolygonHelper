//
//  ViewController.swift
//  YZPolygonHelperDemo
//
//  Created by Yichi on 16/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var mainView:PolygonView!
	var polygon1:Polygon = Polygon()
	var myTimer:NSTimer!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		//
		// The previous algorithm wouldn't work if the polygon is a rectangle
		// Testing
		let points =
		[
			CGPointMake(10, 10),
			CGPointMake(50, 10),
			CGPointMake(50, 50),
			CGPointMake(10, 50),
		]
		let center:CGPoint =
			YZPolygonHelper.findCentroidForNumberOfPoints(
				points.count,
				
				xAtIndexBlock: { (UInt idx) -> CGFloat in
					
					let point = points[idx]
					return point.x
				},
				
				yAtIndexBlock:{ (UInt idx) -> CGFloat in
					
					let point = points[idx]
					return point.y
				}
		)
		
		println(center)
		
		
		//
		// Set up the polygon view
		self.mainView = PolygonView(frame: self.view.bounds)
		self.view.addSubview(mainView)
		
		var w:CGFloat = self.mainView.bounds.size.width * 0.5
		var h:CGFloat = self.mainView.bounds.size.height * 0.5
		
		for i in 0...7{
			var amount:CGFloat!
			amount = CGFloat(i) * CGFloat(M_PI/4)
			
			let radius = CGFloat(80)
			//CGFloat(UInt(arc4random_uniform(UInt32(80)))) + 20
			
			var controlPoint = ControlPointView(frame: CGRectMake(0.0, 0.0, 20.0, 20.0))			
			var x:CGFloat = w + CGFloat(sinf(Float(amount))) * radius
			var y:CGFloat = h + CGFloat(cosf(Float(amount))) * radius
			
			controlPoint.center = CGPointMake(x, y)
			
			self.polygon1.controlPointViewsArray.append(controlPoint)
		}
		
		self.mainView.addPolygon(self.polygon1)
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		self.myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		myTimer.invalidate()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func timerFired(object:AnyObject) {
		/*
		UIView.animateWithDuration(
			0.99,
			animations: { () -> Void in
				
				self.mainView.updatePolygons()
		})
		*/
		self.mainView.updatePolygons()
//		 Playing with it
//		self.mainView.setNeedsDisplayInRect(CGRectMake(0, 0, CGRectGetMidX(self.mainView.frame), CGRectGetMidY(self.mainView.frame)))
		self.mainView.setNeedsDisplay()
	}

}

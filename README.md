# UGLetterboxingEffectAnimator

Letterboxing is a method of displaying a widescreen film on a narrower screen (such as a 16:9 or old 4:3 aspect ratio) without distorting or losing any of the original image. As a result of this process, black bars appear at the top and bottom of the frame.

## What it looks like

<img width="295" height="640" alt="Example" src="https://github.com/user-attachments/assets/708ab529-59b9-4142-b576-a273df529c26" />

## Description

Animation of the screen narrowing from the top and bottom. Two black cinematic bars smoothly slide toward the center but stop short of meeting (cinema effect).

## Usage example

### Initialization

``` swift

 let movieScreenAnimator = UGLetterboxingEffectAnimator(
     on: view,
     inputData: UGLetterboxingEffectInputData(
         isLeavingAnimation: true,
         subviewBackgroundColor: UIColor.black,
         subviewBorderColor: UIColor.white.cgColor,
         screenWidth: 300,
         padding: 120,
         alpha: 10
     )
 )

 ```

**view** - The view to which visual elements will be added.

**isLeavingAnimation** - A flag that sets the initial position of the cinematic lines. **True** - If you want the lines to be initially visible. **False** - If you want the lines to be off-screen.

**subviewBackgroundColor** - The color of the subview bars.

**subviewBorderColor** - The border color of the subview bars.

**screenWidth** - The width of the screen.

> [!NOTE]
> Note: screenWidth is passed in if the view's dimensions are not yet known.

**padding** - Padding from the edge of the screen to the maximum edge of the bar.

**alpha** - The tilt angle of the plate.

---

### Animation

``` swift
animator?.animate()
```

Tracking which direction the animation moves is done automatically and depends on the initial isLeavingAnimation parameter.

---

### Calculations

<img width="310" height="599" alt="image" src="https://github.com/user-attachments/assets/9bb15efa-7b31-44d0-862b-8a86dd7ae6b2" />

FGRP - phone screen

FG - screen width

FD - how far the panel extends

∠𝛼 - rotation angle of the view

> [!NOTE]
> Why can't the strip dimensions be set manually?
> Because manual input of the sides would not result in the rectangle fitting optimally into the screen corners.

- **FB**

△FBG - right-angled triangle

cos(𝛼) = FB / FG

FB = FG * cos(𝛼)

- **AB**

∠ADC = 90°

∠β = 180° - ∠𝛼 - 90° = 90° - ∠𝛼

∠γ = 90° - ∠β = 90° - 90° + ∠𝛼 = ∠𝛼

sin(𝛼) = AF / FD

AF = FD * sin(𝛼)

AB = AF + FB = FD * sin(a) + FG * cos(𝛼)

- **AD**

cos(𝛼) = AD / FD

AD = FD * cos(𝛼)

- **AE**

sin(𝛼) = AE / AD

AE = AD * sin(𝛼)

AE = FD * cos(𝛼) * sin(𝛼)

- **Consclusion**

AE - left constraint

𝛼 – rotation angle of topView and bottomView

FD – top constraint

AB – view width

AD – view height

AE = SN

MR = FD

ABCD = LMNO

## Installation

### Swift Package Manager

Add the following dependency to your Package.swift:

``` swift
dependencies: [
    .package(url: "https://github.com/UnrealGlitch/UGLetterboxingEffectAnimator.git", from: "1.0.0")
]
```

Or via Xcode:

- Go to File → Add Package Dependencies...
- Enter the repository URL: https://github.com/UnrealGlitch/UGLetterboxingEffectAnimator.git
- Select the version rule (e.g., "Up to Next Major") and click Add Package

## License

Apache 2.0

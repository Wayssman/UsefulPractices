# Alpha Select Layer Hack

This view implements tap-detection on irregular shapes (head parts) without using UIBezierPath or hit-testing polygons.
Instead, it uses a reliable and fast trick:
Draw each area as an image and detect taps by reading the pixel’s alpha value.

https://github.com/user-attachments/assets/73c76da4-16bc-45e7-bea1-560e15e48308


import numpy as np
import matplotlib.pyplot as plt
from Ellipsoids import Ellipsoid

# Erstelle eine gemeinsame Figure und Achse
fig, ax = plt.subplots(figsize=(8, 8))


# # Erste Ellipse (blau)
E1 = Ellipsoid(np.array([[1 / 9, 0], [0, 1 / 4]]), np.array([0, 0]))
E1.plot(ax=ax, color="black", alpha=0.1)


# # Zweite Ellipse (grün)
E3 = Ellipsoid(np.array([[1, 0], [0, 1]]), np.array([0, 0]))
E3.plot(ax=ax, color="green", alpha=0.5, label="E3")

# Dritte Ellipse (3D)
E3 = 4 * Ellipsoid(
    np.array([[1 / 9, 0, 0], [0, 1 / 4, 0], [0, 0, 1]]), np.array([0, 0, 0])
)
E3.plot(ax=ax, color="blue", alpha=0.1, label="E2")

# Formatierung
ax.set_title("Vergleich mehrerer Ellipsoide")
ax.set_xlabel("X-Achse")
ax.set_ylabel("Y-Achse")
ax.set_aspect("equal")
ax.legend()
plt.grid(True)
plt.show()

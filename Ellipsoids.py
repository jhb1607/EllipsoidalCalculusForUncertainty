import numpy as np
from scipy.special import gamma
import matplotlib.pyplot as plt
from scipy import linalg

class Ellipsoid:
    def __init__(self, P, c):
        P_ = (P + P.T) / 2  # Ensure symmetry
        if np.all(np.linalg.eigvals(P_) > 0):
            self.P = P_
            self.c = np.array(c)
        else:
            raise ValueError("P must be a positive definite matrix")
    
    def __mul__(self, r):
        """Scalar multiplication"""
        return Ellipsoid(self.P * (1/r), self.c)
    
    def __rmul__(self, r):
        """Right scalar multiplication"""
        return self * r
    
    def __truediv__(self, r):
        """Division by scalar"""
        return self * (1/r)
    
    def center_distance(self, other):
        """Distance between centers of two ellipsoids"""
        return np.linalg.norm(self.c - other.c)
    
    def point_center_distance(self, x):
        """Distance from point to ellipsoid center"""
        return np.linalg.norm(self.c - x)
    
    def volume(self):
        """Compute the volume of the ellipsoid"""
        n = len(self.c)
        return np.pi**(n/2) / gamma(n/2 + 1) * np.sqrt(np.linalg.det(np.linalg.inv(self.P)))
    
    def get_center(self):
        """Return the center of the ellipsoid"""
        return self.c
    
    def get_dims(self):
        """Return the dimension of the ellipsoid"""
        return len(self.c)
    
    def scale(self, alpha):
        """Scale the ellipsoid"""
        return Ellipsoid(self.P * (1/alpha), self.c * alpha)
    
    def plot(self, ax=None, label=None, color=None, alpha=0.5):
        """Plot the ellipsoid (2D or 3D)"""
        if ax is None:
            fig = plt.figure()
            if self.get_dims() == 3:
                ax = fig.add_subplot(111, projection='3d')
            else:
                ax = fig.add_subplot(111)
        
        # For 2D ellipsoids
        if self.get_dims() == 2:
            t = np.linspace(0, 2*np.pi, 100)
            circle = np.vstack([np.cos(t), np.sin(t)])
            
            # Apply transformation
            L = linalg.cholesky(np.linalg.inv(self.P))
            ellipse = np.dot(L, circle) + self.c.reshape(-1, 1)
            
            ax.plot(ellipse[0], ellipse[1], label=label, color=color)
            ax.fill(ellipse[0], ellipse[1], alpha=alpha, color=color)
            
        # For 3D ellipsoids
        elif self.get_dims() == 3:
            u = np.linspace(0, 2*np.pi, 30)
            v = np.linspace(0, np.pi, 30)
            
            x = np.outer(np.cos(u), np.sin(v))
            y = np.outer(np.sin(u), np.sin(v))
            z = np.outer(np.ones_like(u), np.cos(v))
            
            sphere = np.vstack([x.flatten(), y.flatten(), z.flatten()])
            
            # Apply transformation
            L = linalg.cholesky(np.linalg.inv(self.P))
            ellipsoid = np.dot(L, sphere) + self.c.reshape(-1, 1)
            
            x = ellipsoid[0].reshape(30, 30)
            y = ellipsoid[1].reshape(30, 30)
            z = ellipsoid[2].reshape(30, 30)
            
            ax.plot_surface(x, y, z, alpha=alpha, color=color)
        
        return ax

# Example usage would be:
# P = np.array([[1, 0], [0, 2]])
# c = np.array([1, 2])
# E = Ellipsoid(P, c)
# E.plot()
# plt.axis('equal')
# plt.show()

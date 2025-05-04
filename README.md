# Possibilistic Uncertainty Modeling with Hyperellipsoids

This project explores possibility theory for describing imprecise probabilities and quantifying uncertainty in engineering, especially where safety and decision-making under incomplete information are critical.

## Key Ideas
- **Possibility Distribution (π):**  
  Maps events to values in [0,1] to rank outcome plausibility.
- **Representation Methods:**  
  Can be analytic, optimization-based, discrete, or sample-based.
- **Hyperellipsoidal Representation:**  
  Uses nested (hyper-)ellipsoids (defined by a center vector and a positive semi-definite matrix) to capture directional uncertainty and correlations—offering advantages over interval boxes and polytopes.

## Goals
- Develop efficient methods to compute overlap ellipsoids (see Fusion).
- **Investigate** the effectiveness of hyperellipsoids in representing possibility distributions.
- **Develop Algorithms** for:
  - **Inference:** Deriving distributions from data.
  - **Propagation:** Transferring uncertainty through functions.
  - **Fusion:** Combining information from different sources.
- **Compare** with alternative approaches in computational efficiency, accuracy, and expressiveness.
- **Demonstrate** practical relevance with a detailed numerical application.

---


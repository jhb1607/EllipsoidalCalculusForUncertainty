% Parameter der Ellipsenungleichung
a3 = 1;
a4 = 2;
c3 = 0;
c4 = 0;
b2 = 0.5;

% Anzahl an Zufallspunkten
N = 1e6;

% Bereich zum Sampling (Box rund um Zentrum)
x_min = -2; x_max = 2;
y_min = -2; y_max = 2;

% Zufällige Punkte in Rechteck
x = x_min + (x_max - x_min) * rand(N, 1);
y = y_min + (y_max - y_min) * rand(N, 1);

% Bedingung für die Ellipse mit xy-Term
in_ellipse = ((x - c3).^2)/a3 + ((y - c4).^2)/a4 + b2 .* x .* y <= 1;

% Monte-Carlo Flächeninhalt = Anteil * Rechtecksfläche
rect_area = (x_max - x_min) * (y_max - y_min);
ellipse_area = rect_area * sum(in_ellipse) / N;

% Ergebnis ausgeben
fprintf("Geschätzter Flächeninhalt der Region: %.4f\n", ellipse_area);

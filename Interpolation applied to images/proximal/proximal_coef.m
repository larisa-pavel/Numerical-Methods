function a = proximal_coef(f, x1, y1, x2, y2)
    % =========================================================================
    % Calculez coeficientii a pentru Interpolarea Proximala intre punctele
    % (x1, y1), (x1, y2), (x2, y1) si (x2, y2).
    % =========================================================================
    % Calculez matricea A.
    A = [1, x1, y1, x1 * y1; 1, x1, y2, x1 * y2; 1, x2, y1, x2 * y1; 1, x2, y2, x2 * y2];
    % Calculez vectorul b.    
    b1 = f(y1, x1);
    b2 = f(y2, x1);
    b3 = f(y1, x2);
    b4 = f(y2, x2);
    b = [b1; b2; b3; b4];
    % Calculez coeficientii.
    a = inv(A)*b;
end 

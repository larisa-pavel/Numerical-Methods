function R = bicubic_resize(I, p, q)
    % =========================================================================
    % Se scaleaza imaginea folosind algoritmul de Interpolare Bicubica.
    % Transforma imaginea I din dimensiune m x n in dimensiune p x q.
    % =========================================================================

    [m n nr_colors] = size(I);
    
    %Initializez matricea finala drept o matrice nula.
    I = double(I);
    R=zeros(p,q);
    % daca imaginea e alb negru, ignora
    if nr_colors > 1
        R = -1;
        return
    end

    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmulteste x si y cu s_x
    % respectiv s_y, atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul [0, n - 1]!


    % Calculeaz factorii de scalare
    % Obs: Daca se lucreaza cu indici in intervalul [0, n - 1], ultimul pixel
    % al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    s_x=(q-1)/(n-1);
    s_y=(p-1)/(m-1);
    % Definesc matricea de transformare pentru redimensionare.
    T=[s_x,0;0,s_y];
    % Calculez inversa transformarii.
    inv_T=inv(T);
    % Precalculez derivatele.
    [Ix, Iy, Ixy] = precalc_d(I);
    % Parcurge fiecare pixel din imagine.
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Aplic transformarea inversa asupra (x, y) si calculez x_p si y_p
            % din spatiul imaginii initiale.
            b=[0;0];
            b=inv_T*[x;y];
            x_p=b(1);
            y_p=b(2);
            % Trec (xp, yp) din sistemul de coordonate 0, n - 1 in
            % sistemul de coordonate 1, n pentru a aplica interpolarea.
            xp=x_p+1;
            yp=y_p+1; 
            % Gasesc cele 4 puncte ce inconjoara punctul x, y
            x1=floor(xp);
            y1=floor(yp);
            x2=x1+1;
            y2=y1+1;
            if(y2==m+1)
                y2=y2-1;
                y1=y2-1;
            end
            if(x2==n+1)
                x2=x2-1;
                x1=x2-1;
            end
            % Calculez coeficientii de interpolare A.
            A = bicubic_coef(I, Ix, Iy, Ixy, x1, y1, x2, y2);
            % Trec coordonatele (xp, yp) in patratul unitate, scazand (x1, y1).
            xp=xp-x1;
            yp=yp-y1;
            % Calculez valoarea interpolata a pixelului (x, y).
            % Obs: Pentru scrierea in imagine, x si y sunt in coordonate de
            % la 0 la n - 1 si trebuie aduse in coordonate de la 1 la n.
            R(y+1,x+1) = [1,xp,xp^2,xp^3]*A*[1,yp,yp^2,yp^3]';
        end
    end
    % Transform matricea rezultata în uint8 pentru a fi o imagine valida.
    R=uint8(R);
end






function R = proximal_resize(I, p, q)
    % =========================================================================
    % Se scaleaza imaginea folosind algoritmul de Interpolare Proximala.
    % Transforma imaginea I din dimensiune m x n în dimensiune p x q.
    % =========================================================================
    [m n nr_colors] = size(I);
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    end
    % Initializez matricea finala drept o matrice nula.
    R = zeros(p, q);

    % Calculez factorii de scalare.
    s_x=(q-1)/(n-1);
    s_y=(p-1)/(m-1);
    % Obs: Daca se lucreaza cu indici din intervalul [0, n - 1], ultimul pixel
    % al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    
    % Definesc matricea de transformare pentru redimensionare.
    T=[s_x,0;0,s_y];
    % Inversez matricea de transformare, FARA a folosi functii predefinite
    [b,c]=size(T);
    Q=zeros(b,c);
    R=zeros(c);
    %Aplic algoritmul Gram-Schmidt modificat prezentat in laboratorul 3
    for i=1:c
        R(i,i)=norm(T(:,i),2);
        Q(:,i)=T(:,i)/R(i,i);
        for j=i+1:c
            R(i,j)=Q(:,i).'*T(:,j);
            T(:,j)=T(:,j)-Q(:,i)*R(i,j);
        end
    end
    Q=Q.';
    inv_T=zeros(c,c);
    %Aplic metoda de rezolvare a unui sistem superior triunghiular
    for j=1:c
        X=zeros(c,1);
        inv(1:c,1)=Q(1:c,j);
        for i=c:-1:1
            X(i,1)=(inv(i,1)-R(i,i+1:c)*X(i+1:c,1))/R(i,i);
        end
        inv_T(1:c,j)=X(:,1);
    end
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Aplic transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            b=[0;0];
            b=inv_T*[x;y];
            x_p=b(1);
            y_p=b(2);
            % Trec (xp, yp) din sistemul de coordonate [0, n - 1] in
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            xp=x_p+1;
            yp=y_p+1; 
            % Calculez cel mai apropiat pixel.
            xp=round(xp);
            yp=round(yp);
            % Calculez valoarea pixelului din imaginea finala.
            % am tinut cont de trecerea din coordonate [0, q-1] in [1,q]
            R(y+1,x+1)=I(yp,xp);
        end
    end
    % Transform matricea rezultata în uint8 pentru a fi o imagine valida.
    R=uint8(R);
end

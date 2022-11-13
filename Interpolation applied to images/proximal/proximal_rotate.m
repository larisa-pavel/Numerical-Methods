function R = proximal_rotate(I, rotation_angle)
    % =========================================================================
    % Rotesc imaginea alb-negru I de dimensiune m x n cu unghiul rotation_angle,
    % aplicând Interpolare Proximala.
    % rotation_angle este exprimat în radiani.
    % =========================================================================
    [m n nr_colors] = size(I);
    I = double(I);
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    end

    % Calculez cosinus si sinus de rotation_angle.
    sin_x=sin(rotation_angle);
    cos_x=cos(rotation_angle);
    % Initializez matricea finala.
    R=zeros(m,n);
    % Calculez matricea de transformare.
    T=[cos_x, -sin_x; sin_x, cos_x];
    % Inversez matricea de transformare, FOLOSIND doar functii predefinite!
    inv_T=inv(T);
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : m - 1
        for x = 0 : n - 1
            % Aplic transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            b=[0;0];
            b=inv_T*[x;y];
            x_p=b(1);
            y_p=b(2);
            % Trec (xp, yp) din sistemul de coordonate [0, n - 1] în
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            xp=x_p+1;
            yp=y_p+1; 
            % Daca xp sau yp se afla în exteriorul imaginii,
            % se pune un pixel negru si se trece mai departe.
            
            % daca xp sau yp este mai mic decat 1 sau mai mare decat n
            % inseamna ca a depasit dimesiunile imaginii, deci pixelul
            % va deveni negru (negru are valoarea 0) + tin cont de trecerea
            % din coordonate [0, q-1] in [1,q]
            if(xp>n||xp<1||yp>n||yp<1)
                R(y+1,x+1)=0;
                % continue trece la urmatoarea iteratie (foarte de folos)
                continue
            end
            % Aflu punctele ce înconjoara(xp, yp).
            x1=floor(xp);
            y1=floor(yp);
            x2=x1+1;
            y2=y1+1;
            %x1 sau y1 poate lua valoarea maxima de n sau m, deci x2 sau y2
            %pot ajunge n+1 sau m+1, care depasesc dimensiunile imaginii, deci,
            %in situatia asta, scad x2 sau y2 cu 1.
            if(y2==m+1)
                y2=y2-1;
                y1=y2-1;
            end
            if(x2==n+1)
                x2=x2-1;
                x1=x2-1;
            end
            % Calculez coeficientii de interpolare notati cu a\
            a=proximal_coef(I,x1,y1,x2,y2);
            % Calculez valoarea interpolata a pixelului (x, y).
            R(y+1,x+1)=a(1)+a(2)*xp+a(3)*yp+a(4)*xp*yp;
        end
    end
    % Transform matricea rezultata în uint8 pentru a fi o imagine valida.
    R=uint8(R);
end

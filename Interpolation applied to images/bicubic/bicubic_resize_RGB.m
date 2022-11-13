function out = bicubic_resize_RGB(img, p, q)
    % =========================================================================
    % Redimensionez imaginea img astfel încât aceasta save fie de dimensiune p x q.
    % Imaginea img este colorata.
    % =========================================================================
    
    % Extrag canalul rosu al imaginii.
    R=img(:,:,1);
    % Extrag canalul verde al imaginii.
    G=img(:,:,2);
    % Extrag canalul albastru al imaginii.
    B=img(:,:,3);
    % Aplicc functia bicubic pe cele 3 canale ale imaginii.
    R_out=bicubic_resize(R,p,q);
    G_out=bicubic_resize(G,p,q);
    B_out=bicubic_resize(B,p,q);
    % Formez imaginea finala concatenand cele 3 canale de culori.
    out=cat(3,R_out,G_out,B_out);
end

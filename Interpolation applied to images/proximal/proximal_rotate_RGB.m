function out = proximal_rotate_RGB(img, rotation_angle)
    % =========================================================================
    % Aplic Interpolarea Proximala pentru a roti o imagine RGB cu un unghi dat.
    % =========================================================================
    
    % Extrag canalul rosu al imaginii.
    R=img(:,:,1);
    % Extrag canalul verde al imaginii.
    G=img(:,:,2);
    % Extrag canalul albastru al imaginii.
    B=img(:,:,3);
    % Aplic rotatia pe fiecare canal al imaginii.
    R_out=proximal_rotate(R,rotation_angle);
    G_out=proximal_rotate(G,rotation_angle);
    B_out=proximal_rotate(B,rotation_angle);
    % Formez imaginea finala concatenând cele 3 canale de culori.
    out=cat(3,R_out,G_out,B_out);
end
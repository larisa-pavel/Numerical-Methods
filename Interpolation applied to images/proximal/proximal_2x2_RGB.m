function out = proximal_2x2_RGB(f, STEP)
    % ==============================================================================================
    % Aplic Interpolare Proximala pe imaginea 2 x 2 definita img cu puncte intermediare echidistante.
    % img este o imagine colorata RGB -Red, Green, Blue.
    % =============================================================================================
 
    % Extrag canalul rosu al imaginii.
    R=f(:,:,1);
    % Extrag canalul verde al imaginii.
    G=f(:,:,2);
    % Extrag canalul albastru al imaginii.
    B=f(:,:,3);
    % Aplic functia proximal pe cele 3 canale ale imaginii.
    R_out=proximal_2x2(R,STEP);
    G_out=proximal_2x2(G,STEP);
    B_out=proximal_2x2(B,STEP);
    % Formeaz imaginea finala concatenând cele 3 canale de culori.
    out=cat(3,R_out,G_out,B_out);
end

function []=adaptiv_lanczos(A,B,C,vect,tol)
  [n,n]=size(A);
  H0=eye(n);
  m=1;
  eroare=1;
  while(eroare>tol)
    [V,W,eroare]=rational_lanczos(A,B,C,vect);
    A=W.'*A*V;
    B=W.'*B;
    C=C*V;
    eroare=norm(eroare);
    m=m+1;
  endwhile
  A
  B
  C
endfunction
function []=lanczos(A,V,W,m)
  
  [n,p]=size(V);
  temp_matrix=A;
  A=W.'*V;
  %Aplic algoritmul Gram-Schmidt modificat pentru descompunerea QR
  [Q,R]=qr_dec(A);
  %R=beta
  %Q=delta
  A=temp_matrix;
  
  V1=V*inv(R);
  W1=W*Q;
  V2=A*V1;
  W2=A.'*W1;
  printf("ITERATIA NUMARUL 1 :\n");
  V1
  W1
  printf("ITERATIA NUMARUL 2 :\n");
  V2
  W2
  %afisez matricile obtinute
  for j=1:m
    %pastrez matricile initiale in variable diferite
    alpha=W1'*V2;
    V2=V2-V1*alpha;
    W2=W2-W1*alpha.';
    %fac descompunerea QR pentru V2 si W2
    [Q1,R1]=qr_dec(V2);
    %Q1=V_j+1;
    %R1=beta_j+1
    [Q2,R2]=qr_dec(W2);
    %Q2=W_j+1;
    %R2=delta_j+1
    [U,S,Z]=svd(Q2.'*Q1);
    %compute singular value decomposition of W_j+1 transpose * V_j+1
    R2=R2.'*U*S.^(1/2);
    R2=R2.';
    R1=S.^(1/2)*Z.'*R1;
    V2=V2*Z*(inv(S).^(1/2));
    W2=W2*U*(inv(S).^(1/2));
    V3=A*V2-V1*R2.';
    W3=A.'*W2-W1*R1.';
    V1=V2;
    W1=W2;
    V2=V3;
    W2=W3;
    printf("ITERATIA NUMARUL %d :\n",j);
    V3
    W3
  endfor
endfunction
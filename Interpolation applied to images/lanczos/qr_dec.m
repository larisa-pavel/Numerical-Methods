function [Q,R] = qr_dec(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
  [m, n] = size(A);
  Q = zeros(m,n);
  R = zeros(n);
  %Aplic algoritmul Gram-Schmidt modificat
  for i=1:n
    R(i,i)=norm(A(:,i),2);
    Q(:,i)=A(:,i)/R(i,i);
    for j=i+1:n
        R(i,j)=Q(:,i).'*A(:,j);
        A(:,j)=A(:,j)-Q(:,i)*R(i,j);
    end
  end
end
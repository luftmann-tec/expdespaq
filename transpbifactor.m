function B=transpbifactor(A,n)
%TRANSPBIFACTOR Transposición en el diseño bifactorial

[i,j]=size(A);
ij=i*j;
in=i/n;

for z=1:j
    for k=1:in
        C=A((k-1)*n+1:k*n,z);
        B((z-1)*n+1:z*n,k)=C;
        %mC=mean(C);
        %resid(k,(z-1)*n+1:z*n)=C-mC;
        %D(k,z)=mC;  %Matriz de valores medios
    end
end

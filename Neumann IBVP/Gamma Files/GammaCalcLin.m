function [F,Mlhs] = GammaCalcLin(Amp,theta,Maxutilde,N,k,CPi,Nz,nEdge,ii)
%NEdge=2;
% N is number of directions 
% i is coll pt 
G = zeros(nEdge,Nz);
for i =1:nEdge %Loop over coll pt, only need to solve Nz equations (Number of directions which dont have zero amplitude for each coll pt on edge).
    AmpTest=Amp; % Resets AmpTest, so we can calculate the correct Amp in line 12. 
    if ii ~=0
        AmpTest((i-1)*N +ii)=[]; %Removes amplitudes corresponding to the theta we dont need to solve for. 
    end
    for n=1:Nz  

     %   G(i) = G(i) + AmpTest(N*(i-1)+n)*exp(1i*(real(k))*(Gamma(n)+ sin(theta(n))*CPi(i))); 
        G(i,n) = AmpTest(N*(i-1)+n)*exp(1i*(real(k))*(sin(theta(n))*CPi(i))); 

    end
       %H(i) = G(i) - Maxutilde(i); % not sure if should be real or not 
       % Relerr(i)=abs(H(i)/Maxutilde(i));
end
% G(ii,:) =[];
% Maxutilde(ii)=[];

SF=min(abs(Maxutilde));

Urhs=1e0.*Maxutilde/SF;


Mlhs=1e0.*(G/SF);
%[Q,R]=qr(Mlhs)
 rank(Mlhs)
 size(Mlhs)

F=pinv(Mlhs)*Urhs;
% F=Mlhs\Urhs;

end
